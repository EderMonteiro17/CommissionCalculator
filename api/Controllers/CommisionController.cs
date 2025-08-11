using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace FCamara.CommissionCalculator.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommisionController : ControllerBase
    {
        private const decimal FCAMARA_LOCAL_COMMISSION_RATE = 0.20m;
        private const decimal FCAMARA_FOREIGN_COMMISSION_RATE = 0.35m;
        private const decimal COMPETITOR_LOCAL_COMMISSION_RATE = 0.02m;
        private const decimal COMPETITOR_FOREIGN_COMMISSION_RATE = 0.0755m;

        [ProducesResponseType(typeof(CommissionCalculationResponse), 200)]
        [ProducesResponseType(typeof(ValidationProblemDetails), 400)]
        [HttpPost("calculate")]
        public IActionResult Calculate([FromBody] CommissionCalculationRequest calculationRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var fcamaraCommission = CalculateFCamaraCommission(
                    calculationRequest.LocalSalesCount,
                    calculationRequest.ForeignSalesCount,
                    calculationRequest.AverageSaleAmount
                );

                var competitorCommission = CalculateCompetitorCommission(
                    calculationRequest.LocalSalesCount,
                    calculationRequest.ForeignSalesCount,
                    calculationRequest.AverageSaleAmount
                );

                var response = new CommissionCalculationResponse
                {
                    FCamaraCommissionAmount = Math.Round(fcamaraCommission, 2),
                    CompetitorCommissionAmount = Math.Round(competitorCommission, 2),
                    LocalSalesCount = calculationRequest.LocalSalesCount,
                    ForeignSalesCount = calculationRequest.ForeignSalesCount,
                    AverageSaleAmount = calculationRequest.AverageSaleAmount
                };

                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "An error occurred while calculating commissions.", details = ex.Message });
            }
        }

        private decimal CalculateFCamaraCommission(int localSales, int foreignSales, decimal averageSaleAmount)
        {
            var localCommission = FCAMARA_LOCAL_COMMISSION_RATE * localSales * averageSaleAmount;
            var foreignCommission = FCAMARA_FOREIGN_COMMISSION_RATE * foreignSales * averageSaleAmount;
            return localCommission + foreignCommission;
        }

        private decimal CalculateCompetitorCommission(int localSales, int foreignSales, decimal averageSaleAmount)
        {
            var localCommission = COMPETITOR_LOCAL_COMMISSION_RATE * localSales * averageSaleAmount;
            var foreignCommission = COMPETITOR_FOREIGN_COMMISSION_RATE * foreignSales * averageSaleAmount;
            return localCommission + foreignCommission;
        }
    }

    public class CommissionCalculationRequest
    {
        [Required(ErrorMessage = "Local sales count is required")]
        [Range(0, int.MaxValue, ErrorMessage = "Local sales count must be a non-negative number")]
        public int LocalSalesCount { get; set; }

        [Required(ErrorMessage = "Foreign sales count is required")]
        [Range(0, int.MaxValue, ErrorMessage = "Foreign sales count must be a non-negative number")]
        public int ForeignSalesCount { get; set; }

        [Required(ErrorMessage = "Average sale amount is required")]
        [Range(0.01, double.MaxValue, ErrorMessage = "Average sale amount must be greater than 0")]
        public decimal AverageSaleAmount { get; set; }
    }

    public class CommissionCalculationResponse
    {
        public decimal FCamaraCommissionAmount { get; set; }
        public decimal CompetitorCommissionAmount { get; set; }
        public int LocalSalesCount { get; set; }
        public int ForeignSalesCount { get; set; }
        public decimal AverageSaleAmount { get; set; }
    }
}
