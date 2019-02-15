pipenv <- function() {
  venv <- system("pipenv --venv", intern = TRUE)
  library(reticulate)
  use_virtualenv(venv, required = TRUE)
}
