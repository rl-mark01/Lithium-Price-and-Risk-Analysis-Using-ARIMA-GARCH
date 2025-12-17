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


### Time Series Visualization
<img width="415" height="324" alt="시각화 캡처" src="https://github.com/user-attachments/assets/be010fdf-d939-4bc6-8def-dc421da89108" />
<img width="404" height="302" alt="acf 캡처" src="https://github.com/user-attachments/assets/455d1421-aaf3-420f-9253-0bf8c0065f38" />
<img width="404" height="298" alt="1차 차분 후 pacf" src="https://github.com/user-attachments/assets/b9d39c31-10b6-4aa3-8489-641b395647f2" />
<img width="404" height="295" alt="최종 잔차 분석 시각화" src="https://github.com/user-attachments/assets/fd4b47ba-63c9-4d4c-903a-9a81c9a029a2" />

