# DATA
players <- read.csv("data/cleaned_data.csv")


# AGE GROUP
players$age_group <- cut(
  players$age,
  breaks = c(-Inf, 23, 29, Inf),
  labels = c("U23", "Prime", "Veteran")
)


# AVERAGE MINUTES
players$avg_minutes <- ifelse(
  players$season_apps > 0,
  players$season_minutes / players$season_apps,
  NA_real_
)


# CONTRACT YEARS REMAINING
reference_date <- as.Date("2025-08-01")
expiration <- as.Date(players$contract_expiration_date)

players$contract_years_remaining <- as.numeric(expiration - reference_date) / 365.25


# VERSATILITY (TWO-FOOTEDNESS)
players$versatility <- ifelse(
  is.na(players$foot),
  NA_integer_,
  ifelse(players$foot == "both", 1L, 0L)
)


# PLAYER POSITION
players$position_group <- factor(
  players$position,
  levels = c("Attack", "Midfield", "Defender"),
  labels = c("Forward", "Midfielder", "Defender")
)

