-module(scavenge_url).
-export([urls2html/2, bin2urls/1]).
-import(lists, [reverse/2,reverse/1, map/2]).

urls2html(Urls, File) ->
  file:write_file(File, urls2html(Urls)).

bin2urls(Bin) ->
  gather_urls(binary_to_list(Bin),[]).

urls2html(Urls) -> [h1(Urls), make_list(Urls)].

h1(Title) -> ["<h1>", Title, "</h1>\n"].

make_list(L) ->
  ["<ul>\n",
  map(fun(I) -> ["<li>", I, "</li>"] end, L),
  "</ul>\n"].

gather_urls("<a href" ++ T, L) ->
  {Url, T1} = collect_url_body(T, reverse("<a href")),
  gather_urls(T1, [Url| L]);
gather_urls([_|T], L) ->
  gather_urls(T, L);
gather_urls([], L) ->
  L.

collect_url_body("</a>" ++ T, L) -> {reverse(L, "</a>"), T};
collect_url_body([H|T], L) -> collect_url_body(T, [H|L]);
collect_url_body([], _) -> {[],[]}.
