install.packages("readxl")
library(readxl)

# 파일 불러오기
data <- read_excel("리튬-시장동향지표.xlsx")

str(data)
head(data)
colnames(data)

install.packages("dplyr")
library(dplyr)

install.packages("lubridate")
library(lubridate)
library(ggplot2)
library(forecast)
library(tseries)

  # 1) 헤더 2줄 제거
  clean <- data[-c(1,2), ]
  
  # 2) 컬럼명 새로 부여 (가독성을 위해)
  colnames(clean) <- c("date_raw", "price", "col3", "col4", "col5")
  
  # 3) 연월을 Date로 변환 ("2025.10" -> 2025-10-01)
  clean$date <- as.Date(paste0(clean$date_raw, ".01"), format = "%Y.%m.%d")
  
  # 4) 가격을 numeric으로 변환
  clean$price <- as.numeric(clean$price)
  
  # 5) 날짜순으로 정렬
  clean <- clean %>% arrange(date)
  
  # 6) 시계열 객체 만들기 (monthly)
  ts_data <- ts(clean$price, frequency = 12,
                   start = c(year(min(clean$date)),
                             month(min(clean$date))))
  
  # 확인
  head(clean)
  ts_data
  
  # 시각화
  autoplot(ts_data) +
    ggtitle("Lithium Price Time Series") +
    xlab("Year") + ylab("Price") +
    theme_minimal()
  
  # ACF
  ggAcf(ts_data, lag.max = 24) +
    ggtitle("ACF of Lithium Price")
  
  
  # Ljung-Box
  Box.test(ts_data, lag = 12, type = "Ljung-Box")
  
  
  # ADF test on original series
  adf_original <- adf.test(ts_data)
  adf_original
  
  
  # 데이터 전처리: 1차 차분 (Differencing)
  diff_ts <- diff(ts_data, differences = 1)
  
  # 차분 후 ADF 검정
  adf_diff <- adf.test(diff_ts)
  print("--- 1차 차분 데이터 ADF 검정 결과 ---")
  print(adf_diff)
 
  # 차분된 데이터 그래프 (추세 제거 확인)
  autoplot(diff_ts) +
    ggtitle("1st Differenced Data (Stationary)") +
    theme_minimal() +
    geom_hline(yintercept = 0, color="red", linetype="dashed")
  
  # ACF·PACF 재확인
  ggAcf(ts_diff)
  ggPacf(ts_diff)
  
  
  # 최적 모형 자동 선택
  fit_auto_diff <- auto.arima(ts_diff)
  summary(fit_auto_diff)
  
  # ARIMA 후보 모형 적합
  fit_011 <- Arima(ts_data, order = c(0,1,1))
  fit_110 <- Arima(ts_data, order = c(1,1,0))
  fit_111 <- Arima(ts_data, order = c(1,1,1))
  
  # AIC 비교
  AIC(fit_011, fit_110, fit_111)
  
  # 파라미터 추정 결과 확인
  best_model <- Arima(ts_data, order=c(0,1,1), include.mean=FALSE)
  summary(best_model)
  
  # 잔차 분석
  checkresiduals(best_model)
  
  
  
  # ARIMA+GARCH 모델 구현
  install.packages("rugarch")
  library(rugarch)
  
  # 모델 설정 (ARIMA(0,1,1) + GARCH(1,1))
  # mean.model: ARIMA 부분 (0, 1, 1)
  # variance.model: GARCH 부분 (1, 1)
  spec <- ugarchspec(
    variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
    mean.model = list(armaOrder = c(0, 1), include.mean = TRUE), 
    distribution.model = "norm" # 정규분포 가정
  )
  
  # 모델 적합 (Fitting)
  garch_fit <- ugarchfit(spec = spec, data = diff_ts)
  
  # 결과 확인
  show(garch_fit)
  