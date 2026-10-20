function CodeBlock(el)
  return pandoc.RawBlock(
    "latex",
    "\\begin{codeblock}\n" .. el.text .. "\n\\end{codeblock}"
  )
end
