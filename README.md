# Automated Risk Management Mechanisms in DeFi Lending Protocols: A Crosschain Comparative Analysis of Aave and Compound

This repository contains code and data for the following research paper.

Iftikhar, E., Wei, W., and Cartlidge J. (2025), **Automated Risk Management Mechanisms in DeFi Lending Protocols: A Crosschain Comparative Analysis of Aave and Compound**, [arXiv:2506.12855](https://doi.org/10.48550/arXiv.2506.12855).

*Abstract: Blockchain-based decentralised lending is a rapidly growing and evolving alternative to traditional lending, but it poses new risks. To mitigate these risks, lending protocols have integrated automated risk management tools into their smart contracts. However, the effectiveness of the latest risk management features introduced in the most recent versions of these lending protocols is understudied. To close this gap, we use a panel regression fixed effects model to empirically analyse the cross-version (v2 and v3) and cross-chain (L1 and L2) performance of the liquidation mechanisms of the two most popular lending protocols, Aave and Compound, during the period Jan 2021 to Dec 2024. Our analysis reveals that liquidation events in v3 of both protocols lead to an increase in total value locked and total revenue, with stronger impact on the L2 blockchain compared to L1. In contrast, liquidations in v2 have an insignificant impact, which indicates that the most recent v3 protocols have better risk management than the earlier v2 protocols. We also show that L1 blockchains are the preferred choice among large investors for their robust liquidity and ecosystem depth, while L2 blockchains are more popular among retail investors for their lower fees and faster execution.*

**Keywords: Blockchain, DeFi, Lending, Risk management**

## Code

Code is written in *R* and is found in file `RegressionCode.R`

## Data

We include three data files:

- `dataRegression.csv`
- `DefiVolume.csv`
- `usage_metrics.csv`

Data has daily frequency and covers the period: **01 Jan 2021 to 31 Dec 2024**.

#### dataRegression.csv ####

This file contains financial and protocol-level data for DeFi lending platforms i.e., Aave and Compound across v2 and v3 versions deployed on Ethereum (L1) and Arbitrum (L2) blockchains. The dataset includes the following:

**Core financial metrics**

TVL, total revenue, liquidations, deposits (in USD)

**Protocol-level risk parameters**

liquidation_penalty, liquidation_threshold, loan-to-value (LTV) ratio for wETH

usdcborrowapr: borrow rate of USDC on each protocol

**Market conditions Variables**

FGI: Fear and Greed Index (crypto market sentiment)

VIX: Volatility Index (traditional financial market sentiment)

ETH: ETH daily returns (to control for price volatility)

fee: gas price on Ethereum and Arbitrum

**Additional variables for robustness checks**

BTC daily returns

USDT borrow rate

**Column Naming Convention**

Each variable follows the format:
[metric]_[protocolID]
Where:

metric = e.g., tvl, revenue, liquidations, etc.

protocolID = aave or compound + v2 or v3 + ethereum or arbitrum

Example: tvl_compoundv2ethereum = TVL of Compound v2 on Ethereum

#### usage_metrics.csv ####

This file contains daily active user counts and daily deposit counts for Compound and Aave platforms, versions v2 and v3, on Ethereum L1 chain and Arbitrum L2 chain. This data is used to plot Fig. 5.


#### DefiVolume.csv ####

This file contains data about the total volume of Defi market as measured in USD. (**Data Source: DefiLamma**).

