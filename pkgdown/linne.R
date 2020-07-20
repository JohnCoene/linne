library(linne)

Linne$
  new()$
  import("https://fonts.googleapis.com/css2?family=Dosis:wght@400;700&family=Ubuntu+Mono&display=swap")$
  define(
    dark = "#264653!important",
    orange = "#e76f51!important"
  )$
  change( # use Dosis
    sel_all(),
    fontFamily = "'Dosis', sans-serif"
  )$
  change( # use Ubuntu font for code 
    sel_tag("code") %or% sel_tag("pre"),
    fontFamily = "'Ubuntu Mono', monospace"
  )$
  change( # change h1 color
    sel_tag("h1"),
    color = dark
  )$
  change(
    sel_attr("toc", "data-toggle") %child% sel_tag("a"),
    color = orange,
  )$
  change( # change other h's
    sel_tag("h2") %or% sel_tag("h3") %or% sel_tag("h4"),
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
  show_css()$
  write("pkgdown/extra.css", pretty = TRUE)

pkgdown::init_site()
