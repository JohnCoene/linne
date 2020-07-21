library(linne)

Linne$
  new()$
  import("https://fonts.googleapis.com/css2?family=Dosis:wght@400;700&family=Fira+Code:wght@300&display=swap")$
  define(
    dark = "#f4a717 !important",
    orange = "#474757 !important"
  )$
  rule( # use Dosis
    sel_tag("body"),
    fontFamily = "'Dosis', sans-serif"
  )$
  rule( # use Ubuntu font for code 
    sel_tag("code") %or% sel_tag("pre") %or% sel_class("r"),
    fontFamily = "'Fira Code', monospace"
  )$
  rule(
    sel_attr("data-toggle", "toc") %child% sel_tag("a"),
    color = orange,
  )$
  rule( # rule other h's
    sel_tag("h1") %or% sel_tag("h2") %or% sel_tag("h3") %or% sel_tag("h4"),
    color = orange
  )$
  rule(
    sel_id("pkgdown-sidebar") %child% sel_tag("h2"),
    color = dark
  )$
  rule( # rule navbar background color
    sel_class("navbar-default"),
    backgroundColor = dark,
    color = "white"
  )$
  rule( # rule text on navbar
    sel_class("navbar-nav") %child% sel_tag("li") %child% sel_tag("a"),
    color = "white !important"
  )$
  rule( # rule color of links
    sel_tag("a"),
    color = orange
  )$
  rule(
    sel_class("btn-copy-ex"),
    backgroundColor = dark,
    color = orange,
    borderColor = dark
  )$
  rule( 
    sel_class("dropdown-menu") %child% sel_tag("li") %child% sel_tag("a"),
    color = "white",
    backgroundColor = dark
  )$
  rule(
    sel_tag("blockquote"),
    borderColor = dark
  )$
  rule(
    sel_class("btn-primary"),
    border = dark,
    backgroundColor = dark
  )$
  show_css()$
  write("pkgdown/extra.css", pretty = TRUE)

pkgdown::init_site()
