import React, { useState } from 'react';
import './App.css';

function App() {
  const [formData, setFormData] = useState({
    localSalesCount: '',
    foreignSalesCount: '',
    averageSaleAmount: ''
  });
  
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const validateForm = () => {
    const { localSalesCount, foreignSalesCount, averageSaleAmount } = formData;
    
    if (!localSalesCount || !foreignSalesCount || !averageSaleAmount) {
      setError('All fields are required');
      return false;
    }
    
    if (parseInt(localSalesCount) < 0 || parseInt(foreignSalesCount) < 0) {
      setError('Sales counts must be non-negative numbers');
      return false;
    }
    
    if (parseFloat(averageSaleAmount) <= 0) {
      setError('Average sale amount must be greater than 0');
      return false;
    }
    
    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    
    if (!validateForm()) {
      return;
    }
    
    setLoading(true);
    
    try {
      const requestData = {
        localSalesCount: parseInt(formData.localSalesCount),
        foreignSalesCount: parseInt(formData.foreignSalesCount),
        averageSaleAmount: parseFloat(formData.averageSaleAmount)
      };

      // Use HTTP for development (more reliable than HTTPS with self-signed certs)
      const response = await fetch('http://localhost:5111/api/commision/calculate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestData)
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Failed to calculate commissions');
      }

      const data = await response.json();
      setResults(data);
    } catch (err) {
      setError(err.message || 'An error occurred while calculating commissions');
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-GB', {
      style: 'currency',
      currency: 'GBP'
    }).format(amount);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Commission Calculator</h1>
        <div className="form-container">
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="localSalesCount">Local Sales Count</label>
              <input
                type="number"
                id="localSalesCount"
                name="localSalesCount"
                value={formData.localSalesCount}
                onChange={handleInputChange}
                min="0"
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="foreignSalesCount">Foreign Sales Count</label>
              <input
                type="number"
                id="foreignSalesCount"
                name="foreignSalesCount"
                value={formData.foreignSalesCount}
                onChange={handleInputChange}
                min="0"
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="averageSaleAmount">Average Sale Amount (£)</label>
              <input
                type="number"
                id="averageSaleAmount"
                name="averageSaleAmount"
                value={formData.averageSaleAmount}
                onChange={handleInputChange}
                min="0.01"
                step="0.01"
                required
              />
            </div>

            <button type="submit" disabled={loading}>
              {loading ? 'Calculating...' : 'Calculate'}
            </button>
          </form>

          {error && (
            <div className="error-message">
              <p>Error: {error}</p>
            </div>
          )}
        </div>
      </header>

      {results && (
        <div className="results-container">
          <h3>Commission Comparison Results</h3>
          <div className="results-grid">
            <div className="result-card fcamara">
              <h4>FCamara Commission</h4>
              <p className="commission-amount">{formatCurrency(results.fCamaraCommissionAmount)}</p>
              <div className="breakdown">
                <p>Local Sales: {results.localSalesCount} × {formatCurrency(results.averageSaleAmount)} × 20% = {formatCurrency(results.localSalesCount * results.averageSaleAmount * 0.20)}</p>
                <p>Foreign Sales: {results.foreignSalesCount} × {formatCurrency(results.averageSaleAmount)} × 35% = {formatCurrency(results.foreignSalesCount * results.averageSaleAmount * 0.35)}</p>
              </div>
            </div>
            
            <div className="result-card competitor">
              <h4>Competitor Commission</h4>
              <p className="commission-amount">{formatCurrency(results.competitorCommissionAmount)}</p>
              <div className="breakdown">
                <p>Local Sales: {results.localSalesCount} × {formatCurrency(results.averageSaleAmount)} × 2% = {formatCurrency(results.localSalesCount * results.averageSaleAmount * 0.02)}</p>
                <p>Foreign Sales: {results.foreignSalesCount} × {formatCurrency(results.averageSaleAmount)} × 7.55% = {formatCurrency(results.foreignSalesCount * results.averageSaleAmount * 0.0755)}</p>
              </div>
            </div>
          </div>
          
          <div className="advantage">
            <h4>FCamara Advantage</h4>
            <p className="advantage-amount">
              {formatCurrency(results.fCamaraCommissionAmount - results.competitorCommissionAmount)} more than competitor
            </p>
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
