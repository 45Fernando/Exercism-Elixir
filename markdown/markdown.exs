defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(m) do
    # Using the pipe operator to make easy to read what is hapenning
    m
    |> String.split("\n")
    |> Enum.map(fn(t) -> process(t) end)
    |> Enum.join
    |> patch
  end

  #Using patern matching and guards to separate each case and make more easy to read
  defp process(<<c>> <> _resto = t) when <<c>> == "#" do
    # Using the pipe operator to make easy to read what is hapenning
    t
    |> parse_header_md_level
    |> enclose_with_header_tag
  end

  defp process(<<c>> <> _resto = t) when <<c>> == "*" do
    # Using the pipe operator to make easy to read what is hapenning
    t
    |> parse_list_md_level
  end

  defp process(t) do
    # Using the pipe operator to make easy to read what is hapenning
    t
    |> String.split
    |> enclose_with_paragraph_tag
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    #binding the variables before the last call, for me is more easy to follow
    # Using the pipe operator to make easy to read what is hapenning
    h = h
        |> String.length
        |> to_string

    t = t
        |> Enum.join(" ")

    {h, t}
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp parse_list_md_level(l) do
    # Using the pipe operator to make easy to read what is hapenning
    t = l
        |> String.trim_leading("* ")
        |> String.split

    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp join_words_with_tags(t) do
    # Using the pipe operator to make easy to read what is hapenning
    t
    |> Enum.map(fn(w) -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    # Using the pipe operator to make easy to read what is hapenning
    w
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(w) do
    # Using the pipe operator to make easy to read what is hapenning
    w
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_prefix("_", "<em>")
  end

  defp replace_suffix_md(w) do
    # Using the pipe operator to make easy to read what is hapenning
    w
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_suffix("_", "</em>")
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp patch(l) do
    # Using the pipe operator to make easy to read what is hapenning
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
