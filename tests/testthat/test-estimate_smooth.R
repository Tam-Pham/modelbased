context("estimate_smooth")



test_that("estimate_smooth", {
  library(rstanarm)
  set.seed(333)

  model <- stan_gamm4(Sepal.Width ~ s(Petal.Length), data = iris, refresh = 0, iter = 2000, chains = 2, seed = 333)
  estim <- estimate_smooth(model)
  testthat::expect_equal(c(nrow(estim), ncol(estim)), c(2, 6))

  model <- stan_glm(Sepal.Width ~ poly(Petal.Length, 2), data = iris, refresh = 0, iter = 2000, chains = 2, seed = 333)
  estim <- estimate_smooth(model)
  testthat::expect_equal(c(nrow(estim), ncol(estim)), c(2, 6))

  model <- stan_glm(Sepal.Width ~ Species * poly(Petal.Length, 2), data = iris, refresh = 0, iter = 2000, chains = 2, seed = 333)
  estim <- estimate_smooth(model)
  testthat::expect_equal(c(nrow(estim), ncol(estim)), c(2, 6))
  estim <- estimate_smooth(model, levels = "Species", smooth_strength = 0.75)
  testthat::expect_equal(ncol(estim), 7)
})