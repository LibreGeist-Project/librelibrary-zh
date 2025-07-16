#import "constant.typ": *
#import "@preview/shadowed:0.2.0": shadowed
#import "@preview/wrap-it:0.1.1": wrap-content
#import "@preview/hydra:0.6.1": hydra
#import "@preview/shadowed:0.2.0": shadowed
#import "@preview/wrap-it:0.1.1": wrap-content

#let gfsize = 15.5mm;
#let isNormalPage = true;
#let bak_font = DEF_ZH_SANS_FONT;

#let def_style(content) = {
  // 链接下划线
  show link: underline.with(offset: auto)

  // 列表设定
  set list(indent: 1.5em)
  set enum(indent: 1.5em)

  // 下划线现在不会挡到汉字
  set underline(offset: 0.2em)

  // 设置表格标题
  show figure.where(kind: table): set figure.caption(position: top)

  // 半宽括号与汉字之间的空格
  let cjk = "(\p{Hiragana}|\p{Katakana}|\p{Han})"
  show regex("(" + cjk + "[(])|([)]" + cjk + ")"): it => {
    let a = it.text.match(regex("(.)(.)"))
    a.captures.at(0)
    h(0.25em)
    a.captures.at(1)
  }

  // 公式与汉字之间的空格
  show math.equation.where(block: false): it => {
      hide[#text(size: 1pt)[\$]]
      it
      hide[#text(size: 1pt)[\$]]
  }

  set page(width: 787mm, height: 1092mm) if (isNormalPage)
  set page(numbering: "1")
  set text(
    font: (
      (name: DEF_EN_SERIF_FONT, covers: "latin-in-cjk"), // English Font
      DEF_ZH_SERIF_FONT,
      bak_font, // Chinese font
    ),
    lang: "zh",
    region: "CN",
    size: gfsize,
    ligatures: true,

  )
  set quote(block: true)
  show quote: set align(center)
  show quote: set pad(x: 1em)
  show quote: text.with(font: "Zhuque Fangsong (technical preview)")
  
  show heading: it => {
    it
    v(0.5em)
  }

  show heading.where(level: 1): it => {
    set align(center+horizon)
    it
  }

  show heading.where(level: 2): it => {
    set align(center)
    it
  }

  set heading(numbering: none)
  set par(leading: 0.8em, spacing: 1em, justify: true, first-line-indent: (
    all: true,
    amount: 2em,
  ))
  

  set math.cancel(stroke: (thickness: 0.1mm))
  content
}

#let prelims(head, content) = {
  set page(footer: none)
  set text(gfsize*1.2)
  set align(center + horizon)
  v(-4em)
  head
  v(3em)
  text(font: "Zhuque Fangsong (technical preview)")[#content]
}
