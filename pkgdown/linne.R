library(linne)

Linne$
  new()$
  import("https://fonts.googleapis.com/css2?family=Dosis:wght@400;700&family=Ubuntu+Mono&display=swap")$
  define(
    dark = "#073b4c",
    blue = "#118ab2",
    green = "#06d6a0",
    yellow = "#ffd166",
    red = "#ef476f"
  )$
  change(
    sel_all(),
    fontFamily = "'Dosis', sans-serif"
  )$
  change(
    sel_tag("code") %or% sel_tag("pre"),
    fontFamily = "'Ubuntu Mono', monospace"
  )$
  change(
    sel_tag("h1") %or% sel_tag("h2") %or% sel_tag("h3") %or% sel_tag("h4"),
    color = dark
  )$
  show_css()$
  save("pkgdown/extra.css")
