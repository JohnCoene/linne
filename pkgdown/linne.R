library(linne)

Linne$
  new()$
  define(
    dark = "#073b4c",
    blue = "#118ab2",
    green = "#06d6a0",
    yellow = "#ffd166",
    red = "#ef476f"
  )$
  change(
    sel_tag("h1") %or% sel_tag("h2") %or% sel_tag("h3") %or% sel_tag("h4"),
    color = dark
  )