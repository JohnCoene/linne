library(linne)

Linne$
  new()$
  import("https://fonts.googleapis.com/css2?family=Dosis:wght@400;700&family=Fira+Code:wght@300&display=swap")$
  define(
    dark = "#f4a717 !important",
    orange = "#474757 !important"
  )$
  change( # use Dosis
    sel_all(),
    fontFamily = "'Dosis', sans-serif"
  )$
  change( # use Ubuntu font for code 
    sel_tag("code") %or% sel_tag("pre"),
    fontFamily = "'Fira Code', monospace"
  )$
  change(
    sel_attr("toc", "data-toggle") %child% sel_tag("a"),
    color = orange,
  )$
  change( # change other h's
    sel_tag("h1") %or% sel_tag("h2") %or% sel_tag("h3") %or% sel_tag("h4"),
    color = orange
  )$
  change(
    sel_id("pkgdown-sidebar") %child% sel_tag("h2"),
    color = dark
  )$
  change( # change navbar background color
    sel_class("navbar-default"),
    backgroundColor = dark,
    color = "white"
  )$
  change( # change text on navbar
    sel_class("navbar-nav") %child% sel_tag("li") %child% sel_tag("a"),
    color = "white !important"
  )$
  change( # change color of links
    sel_tag("a"),
    color = orange
  )$
  change(
    sel_class("btn-copy-ex"),
    backgroundColor = dark,
    color = orange,
    borderColor = dark
  )$
  change( 
    sel_class("dropdown-menu") %child% sel_tag("li") %child% sel_tag("a"),
    color = "white",
    backgroundColor = dark
  )$
  change(
    sel_tag("blockquote"),
    borderColor = dark
  )$
  show_css()$
  write("pkgdown/extra.css", pretty = TRUE)

pkgdown::init_site()
