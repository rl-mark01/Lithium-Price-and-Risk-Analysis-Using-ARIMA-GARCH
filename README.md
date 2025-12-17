# Lithium-Price-and-Risk-Analysis-Using-ARIMA-GARCH

## 📈 Lithium Price Time Series Analysis (R)

### Background
This project analyzes monthly lithium price data to understand
trend, stationarity, and volatility characteristics of the lithium market.

### Data
- Monthly lithium price indicators
- Preprocessed from Excel format

### Methodology
- Time series visualization
- Stationarity test (ADF test)
- First differencing
- ARIMA model selection and estimation
- ARIMA–GARCH(1,1) modeling for volatility

### Key Findings
- Original series is non-stationary
- First differencing achieves stationarity
- ARIMA(0,1,1) selected based on AIC
- Significant ARCH effect captured by GARCH(1,1)

### Tools
- R
- forecast, tseries, rugarch, ggplot2

### How to Run
1. Install required packages
2. Run `lithium_price_arima_garch.R`
