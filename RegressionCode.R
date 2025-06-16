#Install packages
install.packages(
  c(
    "tidyr", "tidyverse", "dplyr", "ggthemes", "margins",
    "skimr", "modelsummary", "sjPlot", "psych", "openxlsx",
    "AER", "haven", "readxl", "readr", "janitor",
    "RColorBrewer", "viridis", "lubridate", "ggplot2",
    "ggridges", "forcats", "gt", "gtsummary", "gtExtras",
    "svglite", "lmtest", "sandwich", "flextable", "zoo",
    "plm", "car", "officer", "broom", "vars", "urca", "tseries"
  ),
  repos = "https://cloud.r-project.org",
  dependencies = TRUE
)

#load required libraries
library(tidyr)
library(tidyverse)
library(dplyr)
library(ggthemes)
library(margins)
library(tidyverse)
library(skimr)
library(modelsummary)
library(sjPlot)
library(psych)
library(openxlsx)
library(tidyverse)
library(AER)
library(haven)
library(readxl)
library(readr)
library(janitor)
library(RColorBrewer)
library(viridis)
library(lubridate)
library(ggplot2)
library(ggridges)
library(dplyr)
library(forcats)
library(gt)
library(gtsummary)
library(gtExtras)
library(svglite)
library(forcats)
library(psych)
library(lmtest)
library(sandwich)
library(flextable)
library(zoo)
library(plm)
library(lmtest)
library(car)
library(dplyr)
library(officer)
library(flextable)
library(broom)
library(vars)
library(urca)
library(tseries)

# Read csv file from directory
selected_data <- read_csv("dataRegression.csv")

#check data values
head(selected_data)
tail(selected_data)

# Converts all column names to snake_case
selected_data <- selected_data %>%
  clean_names()

# Convert the date column to a Date object
selected_data$date <- as.Date(selected_data$date, format = "%d/%m/%Y")

# make data tidy (make long)
selected_data_tidy <- selected_data |>
  pivot_longer(
    cols = !date,  # Exclude date, transform everything else
    names_to = "metric_protocol",
    values_to = "value"
  )

# Check if names are correct
colnames(selected_data_tidy)
unique(selected_data_tidy$metric_protocol)  

head(selected_data_tidy)
tail(selected_data_tidy)

#protocol ID
selected_data_tidy <- selected_data_tidy |>
  separate(
    metric_protocol,
    into = c("metric", "protocol"),
    sep = "_",  # Split at the underscore
    remove = TRUE
  )

#
selected_data_tidy <- selected_data_tidy |>
  pivot_wider(
   # Create separate columns for each metric
    names_from = metric, 
   # Populate the columns with the corresponding values
    values_from = value   
  )

#check final data
view(selected_data_tidy)
head(selected_data_tidy)
tail(selected_data_tidy)
colnames(selected_data)
unique(selected_data_tidy$metric_protocol)
selected_data$date <- as.Date(selected_data$date, format = "%Y/%m/%d")


# Handling missing values from all the variables
selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(liquidate))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(usdcborrowapr))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(deposit))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(liquidationthreshold))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(liquidationpenalty))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(borrowed))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(repay))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(fee))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(btc))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(eth))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(usdtborrowapr))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(withdraw))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(vix))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(fgi))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(totalrevenue))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(ltv))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(flashloans))


selected_data$date <- as.Date(selected_data$date, format = "%Y/%m/%d")

#Z-score normalization was initially used (based on previous studies) to normalize the data. 
#However, the resulting residuals were not normally distributed and showed signs of skewness. 
#Therefore, a log transformation was applied instead, to better meet the assumptions of regression analysis.
  
#z score standardization
selected_data_tidy <- selected_data_tidy %>%
  mutate(
    liquidate_std = (liquidate - mean(liquidate, na.rm = TRUE)) / sd(liquidate, na.rm = TRUE),
    usdcborrowapr_std = (usdcborrowapr - mean(usdcborrowapr, na.rm = TRUE)) / sd(usdcborrowapr, na.rm = TRUE),
    usdtborrowapr_std = (usdtborrowapr - mean(usdtborrowapr, na.rm = TRUE)) / sd(usdtborrowapr, na.rm = TRUE),
    eth_std = (eth - mean(eth, na.rm = TRUE)) / sd(eth, na.rm = TRUE),
    btc_std = (btc - mean(btc, na.rm = TRUE)) / sd(btc, na.rm = TRUE),
    fee_std = (fee - mean(fee, na.rm = TRUE)) / sd(fee, na.rm = TRUE),
    tvl_std = (tvl - mean(tvl, na.rm = TRUE)) / sd(tvl, na.rm = TRUE),
    borrowed_std = (borrowed - mean(borrowed, na.rm = TRUE)) / sd(borrowed, na.rm = TRUE),
    totalrevenue_std = (totalrevenue - mean(totalrevenue, na.rm = TRUE)) / sd(totalrevenue, na.rm = TRUE),
    fgi_std = (fgi - mean(vix, na.rm = TRUE)) / sd(fgi, na.rm = TRUE),
    liquidity = (deposit - borrowed),
    liquidity_std = (liquidity - mean(liquidity, na.rm = TRUE)) / sd(liquidity, na.rm = TRUE),
    withdraw_std = (withdraw - mean(withdraw, na.rm = TRUE)) / sd(withdraw, na.rm = TRUE),
    vix_std = (vix - mean(vix, na.rm = TRUE)) / sd(vix, na.rm = TRUE)
  )
  
  
# Log transformation
  
selected_data_tidy <- selected_data_tidy %>%
  mutate(
    usdcborrowapr_log = log(usdcborrowapr),
    liquidate_log = log1p(liquidate),
    usdtborrowapr_log = log(usdtborrowapr),
    btc_log = log1p(btc),
    fee_log = log(fee),
    eth_log = log1p(eth),
    tvl_log = log(tvl),
    fgi_log = log(fgi),
    borrowed_log = log(borrowed),
    deposit_log = log(deposit),
    repay_log = log(repay),
    withdraw_log = log(withdraw),
    flashloans_log = log(flashloans),
    totalrevenue_log = log(totalrevenue),
    vix_log = log(vix),
    volatility_eth = rollapply(eth, width = 7, FUN = sd, align = "right",fill = NA),
    feereturn = c(NA, diff(log(fee))),
    volatility_feereturn = rollapply(feereturn, width = 7, FUN = sd, align = "right",fill = NA),
    volatility_usdcborrowapr = rollapply(usdcborrowapr, width = 7, FUN = sd, align = "right",fill = NA)
  ) 

#Handling N/A values form computed variables
selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(volatility_eth))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(volatility_feereturn))

selected_data_tidy <- selected_data_tidy %>%
  filter(!is.na(volatility_usdcborrowapr))

#Dummy Variables
selected_data_tidy <- selected_data_tidy %>%
  mutate(
    version_dummy = ifelse(grepl("v3", protocol), 1, 0),
    layer_dummy = ifelse(grepl("arbitrum", protocol), 1, 0),
    platform_dummy = ifelse(grepl("aave", protocol), 1, 0)
  )


#Count the number of observations for each dummy
table(selected_data_tidy$version_dummy)
table(selected_data_tidy$layer_dummy)
table(selected_data_tidy$platform_dummy)


#Computation of Default risk metric (DRM)
selected_data_tidy$DRM <- selected_data_tidy$ltv / selected_data_tidy$liquidationthreshold * (1 + selected_data_tidy$liquidationpenalty)


# Convert the data to a panel data frame format, specifying 'protocol' as the individual and 'date' as the time index
pdata <- pdata.frame(selected_data_tidy, index = c("protocol", "date"))



#Fixed Effect Panel Regression (Model 1)
model <- plm(tvl_log ~ version_dummy*liquidate_log  + layer_dummy*liquidate_log  + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)

#residual distribution
resid <- residuals(model)
qqnorm(resid)
qqline(resid, col = "red")

#Fixed Effect Panel Regression (Model 2)
model <- plm(totalrevenue_log ~ version_dummy*liquidate_log  + layer_dummy*liquidate_log  + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)

#Fixed Effect Panel Regression (Model 3)
model <- plm(tvl_log ~ version_dummy*liquidate_log  + platform_dummy*liquidate_log  + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)


#Fixed Effect Panel Regression (Model 4)
model <- plm(totalrevenue_log ~ version_dummy*liquidate_log  + platform_dummy*liquidate_log  + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)


#Fixed Effect Panel Regression (Model 1 Appendix)
model <- plm(tvl_log ~ version_dummy*liquidate_log  + platform_dummy*liquidate_log + layer_dummy*liquidate_log + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)


#Fixed Effect Panel Regression (Model 2 Appendix)
model <- plm(totalrevenue_log ~ version_dummy*liquidate_log  + platform_dummy*liquidate_log + layer_dummy*liquidate_log + DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
             data = pdata, model = "within")
summary(model)


#VIF calculation
model <- lm(tvl_log ~ liquidate_log +  DRM + volatility_usdcborrowapr  + volatility_feereturn + volatility_eth  + fgi_log + vix_log +withdraw_log,
            data = pdata)
summary(model)
vif(model)