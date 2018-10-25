resource "heroku_app" "marsi-science" {
  name   = "marsi-science"
  region = "us"
  acm    = true
  stack  = "heroku-16"

  organization = {
    name = "mars"
  }

  config_vars {
    PUBLIC_URL              = "https://www.marsi.science"
    S3_BUCKET_REGION        = "us-east-1"
    privacy__useUpdateCheck = "false"
  }
}

resource "heroku_domain" "www-marsi-science" {
  app      = "${heroku_app.marsi-science.id}"
  hostname = "www.marsi.science"
}

resource "heroku_addon" "marsi-science-bucketeer" {
  app  = "${heroku_app.marsi-science.id}"
  plan = "bucketeer:hobbyist"
}

resource "heroku_addon" "marsi-science-jawsdb" {
  app  = "${heroku_app.marsi-science.id}"
  plan = "jawsdb:leopard"
}

resource "heroku_addon" "marsi-science-mailgun" {
  app  = "${heroku_app.marsi-science.id}"
  plan = "mailgun:starter"
}

resource "heroku_pipeline" "marsi-science" {
  name = "marsi-science"
}

resource "heroku_pipeline_coupling" "marsi-science-production" {
  app      = "${heroku_app.marsi-science.id}"
  pipeline = "${heroku_pipeline.marsi-science.id}"
  stage    = "production"
}
