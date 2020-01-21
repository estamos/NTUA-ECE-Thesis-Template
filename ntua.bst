%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Based on hellas.bst by Apostolos Syropoulos
%%
%% Modified by Evangelos Stamos , January 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    foreign-author %Just in case in a greek conference a foreigner makes
    foreign-title  %an announcement in a language other than greek...
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    original-title %when a document is a translation
    pages
    publisher
    school
    series
    title
    translator     %the name of the translator(s)
    type
    volume
    year
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
    'skip$
    { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {colorize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\color{\colouredtextcolor} " swap$ * "}" * }
  if$
}

FUNCTION {latinize}  %%% Used to produce latin text for most
{ duplicate$ empty$  %%% standard bibliographic record types
    { pop$ "" }
    { "{{\latintext " swap$ * "}}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff{ }}{vv{ }}{{ }ll}{, jj}" format.name$ 't :=
      nameptr #1 >
    { namesleft #1 >
       { ", " * t * }
       { t "others" =
          { " \textgreek{k.'a.} " * }
          { " \textgreek{kai} " * t * }
         if$
        }
    if$
    }
    't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
    { ", \textgreek{epimelht'es}" * }
    { ", \textgreek{epimelht'hs}" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    {title}
  if$
}

%FUNCTION {format.original-title} %%the title explains the functionality!
%{ title empty$
%    { "" }
%    { "\textgreek{T'itlos prot'otupou}: " original-title * "t" change.case$ }
%  if$
%}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
        { "--" *
          t #2 global.max$ substring$ 't :=
        }
        {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
          while$
        }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
    { "" }
    { "there's a month but no year in " cite$ * warning$
      month
    }
      if$
    }
    { month empty$
    'year
    { " " " " * year * }
      if$
    }
  if$
}

%FUNCTION {format.btitle}
%{ title emphasize
%}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "\nobreakspace{}" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "\textgreek{t'omos}" volume tie.or.space.connect
      series empty$
    'skip$
    { " \textgreek{sto} " * series latinize emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
    { series field.or.null }
    { output.state mid.sentence =
        { "\textgreek{arijm'os}" }
        { "\textgreek{Arijm'os}" }
      if$
      number tie.or.space.connect
      series empty$
        { "there's a number but no series in " cite$ * warning$ }
        { " \textgreek{sto} " * series latinize * }
      if$
    }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
    { edition "\textgreek{h}" * "l" change.case$ " \textgreek{'ekdosh}" * }
    { edition "\textgreek{h}" * "t" change.case$ " \textgreek{'ekdosh}" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
    { "\textgreek{sel'ides}" pages n.dashify tie.or.space.connect }
    { "\textgreek{sel'ida}" pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
    { "there's a number but no volume in " cite$ * warning$ }
    'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
    { pop$ format.pages }
    { ":" * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
    { "\textgreek{kef'alaio}" }
    { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
    'skip$
    { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
    { " " booktitle emphasize * }
    { " " booktitle emphasize * format.editors * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "\textgreek{Teqnik'h Anafor'a me arijm'o}" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.patent.number}
{ type empty$
    { "\textgreek{D'iplwma Euresiteqn'iac }" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
    { "need key or journal for " cite$ * " to crossref " * crossref *
      warning$
      ""
    }
    { "Sto {\em " journal * "\/}" * }
      if$
    }
    { "Sto " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv{ }}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " k.'a.\ " * }
    { #2 <
    'skip$
    { editor #2 "{ff{ }}{vv{ }}{ll}{, jj}" format.name$ "others" =
        { " k.'a. " * }
        { " kai " * editor #2 "{vv{ }}{ll}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "\textgreek{T'omos}" volume tie.or.space.connect
      " \textgreek{ths} " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { series empty$
        { "need editor, key, or series for " cite$ * " to crossref " *
          crossref * warning$
          "" *
        }
        { "{\em " * series * "\/}" * }
      if$
    }
    { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { booktitle empty$
        { "need editor, key, or booktitle for " cite$ * " to crossref " *
          crossref * warning$
          ""
        }
        { "Sto {\em " booktitle * "\/}" * }
      if$
    }
    { "Sto " key * }
      if$
    }
    { "Sto " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize colorize latinize "title" output.check
  new.block
  crossref missing$
    { journal emphasize latinize "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref latinize output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {gr-article}
{ output.bibitem
  translator missing$
     { format.authors "author" output.check }
     { format.authors latinize "author" output.check }
  if$
  new.block
  format.title emphasize colorize "title" output.check
  translator missing$
     'skip$
     { new.block
       original-title missing$
          'skip$
          {
            "\textgreek{T'itlos prot'otupou}: "
            original-title * "t" change.case$ output
          }
%         { format.original-title latinize "original-title" output }
       if$
       "Met'afrash: " translator format.names * output
%       format.translators "translator" output.check
     }
  if$
  new.block
  crossref missing$
    { journal emphasize  "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref latinize output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors latinize "author and editor" output.check }
    { format.authors latinize output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  title emphasize colorize latinize "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series latinize output
      new.sentence
      publisher latinize "publisher" output.check
      address latinize output
    }
    { new.block
      format.book.crossref latinize output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {gr-book}
{ output.bibitem
  translator missing$
     {
       author empty$
         { format.editors  "author and editor" output.check }
         { format.authors  output.nonnull
           crossref missing$
         { "author and editor" editor either.or.check }
         'skip$
           if$
         }
       if$
     }
     {
       author empty$
         { format.editors  latinize "author and editor" output.check }
         { format.authors  latinize output.nonnull
           crossref missing$
         { "author and editor" editor either.or.check }
         'skip$
           if$
         }
       if$
     }
  if$
  new.block
  title emphasize colorize "title" output.check
  translator missing$
     'skip$
     { new.block
       original-title missing$
          'skip$
          { "\textgreek{T'itlos prot'otupou}: " original-title *
            "t" change.case$ output
          }
%          { format.original-title latinize "original-title" output }
       if$
       "Met'afrash: " translator format.names * output
%       format.translators "translator" output.check
     }
  if$
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series  output
      new.sentence
      publisher "publisher" output.check
      address  output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}


FUNCTION {booklet}
{ output.bibitem
  format.authors latinize output
  new.block
  format.title emphasize colorize latinize "title" output.check
  howpublished address new.block.checkb
  howpublished  output
  address latinize output
  format.date output
  new.block
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  translator missing$
     {
       author empty$
         { format.editors  latinize "author and editor" output.check }
         { format.authors  latinize output.nonnull
           crossref missing$
         { "author and editor" editor either.or.check }
         'skip$
           if$
         }
       if$
     }
     {
       author empty$
         { format.editors  latinize "author and editor" output.check }
         { format.authors  latinize output.nonnull
           crossref missing$
         { "author and editor" editor either.or.check }
         'skip$
           if$
         }
       if$
     }
  if$
  new.block
  title emphasize colorize latinize "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series latinize output
      new.sentence
      publisher latinize "publisher" output.check
      address latinize output
    }
    { format.chapter.pages latinize "chapter and pages" output.check
      new.block
      format.book.crossref latinize output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {gr-inbook}
{ output.bibitem
  author empty$
    { format.editors latinize "author and editor" output.check }
    { format.authors latinize output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  title emphasize colorize "title" output.check
  translator missing$
     'skip$
     { new.block
       original-title missing$
          'skip$
          {
            "\textgreek{T'itlos prot'otupou}: " original-title *
            "t" change.case$ output
          }
%          { format.original-title latinize "original-title" output }
       if$
       "Met'afrash: " translator format.names * output
%       format.translators "translator" output.check
     }
  if$
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle latinize "booktitle" output.check
      format.bvolume output
      format.number.series latinize output
      format.chapter.pages output
      new.sentence
      publisher latinize "publisher" output.check
      address latinize output
      format.edition latinize output
      format.date "year"  output.check
    }
    { format.incoll.inproc.crossref latinize output.nonnull
      format.chapter.pages latinize output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle latinize "booktitle" output.check
      format.bvolume output
      format.number.series latinize output
      format.pages output
      address empty$
    { organization publisher new.sentence.checkb
      organization latinize output
      publisher latinize output
      format.date "year" output.check
    }
    { address latinize output.nonnull
      format.date "year" output.check
      new.sentence
      organization latinize output
      publisher latinize output
    }
      if$
    }
    { format.incoll.inproc.crossref latinize output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {gr-inproceedings}
{ output.bibitem
  foreign-author missing$
     { translator missing$
          { format.authors output
            new.block
            format.title emphasize colorize "title" output.check
          }
          { format.authors latinize output
            new.block
            format.title emphasize colorize "title" output.check
            "Met'afrash: " translator format.names * output
%            format.translators "translator" output
            original-title  missing$
               'skip$
               {
                 "\textgreek{T'itlos prot'otupou}: " original-title *
                 "t" change.case$ output
               }
%               { format.original-title latinize "original-title" output }
            if$
          }
       if$
     }
     { foreign-author format.names latinize output.check
       new.block
       foreign-title missing$
          { format.title emphasize colorize "title" output.check }
          { format.title emphasize colorize "foreign-title" latinize output.check }
       if$
      }
  if$
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series  output
      format.pages output
      address empty$
    { organization publisher new.sentence.checkb
      organization output
      publisher  output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      organization output
      publisher output
    }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {gr-conference} { gr-inproceedings }

FUNCTION {gr-manual}
{ output.bibitem
  translator missing$
     {
       author empty$
          {
           organization empty$
          'skip$
           { organization  output.nonnull
             address output
           }
           if$
          }
          { format.authors latinize output.nonnull }
       if$
     }
     {
       author empty$
          {
           organization empty$
          'skip$
           { organization  latinize output.nonnull
             address latinize output
           }
           if$
          }
          { format.authors latinize output.nonnull
          }
       if$
       "Met'afrash: " translator format.names * output
%       format.translators "translator" output
     }
  if$
  new.block
  title emphasize colorize "title" output.check
  original-title missing$
     'skip$
     {
       "\textgreek{T'itlos prot'otupou}: " original-title *
       "t" change.case$ output
     }
%      { format.original-title latinize "original-title" output }
  if$
  translator missing$
     'skip$
     {
       "Met'afrash: " translator format.names * output }
%    { format.translators "translator" output }
  if$
  author empty$
     { organization empty$
      { address new.block.checka
        address output
      }
      skip$
       if$
     }
     { organization address new.block.checkb
       organization  output
       address output
     }
   if$
  format.edition output
  format.date output
  new.block
  note output
  fin.entry
}

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
    'skip$
    { organization latinize output.nonnull
      address latinize output
    }
      if$
    }
    { format.authors latinize output.nonnull }
  if$
  new.block
  title emphasize latinize colorize "title" output.check
  author empty$
    { organization empty$
    { address new.block.checka
      address latinize output
    }
    'skip$
      if$
    }
    { organization address new.block.checkb
      organization latinize output
      address latinize output
    }
  if$
  format.edition latinize output
  format.date output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  "\textgreek{Metaptuqiak'h diplwmatik'h ergas'ia}" format.thesis.type
                                        latinize output.nonnull
  school latinize "school" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {diplomathesis}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  "\textgreek{Diplwmatik'h ergas'ia}" format.thesis.type
                                        latinize output.nonnull
  school latinize "school" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {ptychionthesis}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  "\textgreek{Ptuqiak'h ergas'ia}" format.thesis.type
                                        latinize output.nonnull
  school latinize "school" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors latinize output
  title howpublished new.block.checkb
  format.title emphasize colorize latinize output
  howpublished new.block.checka
  howpublished latinize output
  format.date output
  new.block
  note output
  fin.entry
  empty.misc.check
}

FUNCTION {gr-misc}
{ output.bibitem
  format.authors latinize output
  translator missing$
     { format.authors output
       title howpublished new.block.checkb
       format.title emphasize colorize "title" output.check
     }
     { format.authors latinize output
       title howpublished new.block.checkb
       format.title emphasize colorize "title" output.check
       "Met'afrash: " translator format.names * output
%       format.translators "translator" output
       original-title  missing$
          'skip$
          {
            "\textgreek{T'itlos prot'otupou}: " original-title *
            "t" change.case$ output
          }
%           { format.original-title latinize "original-title" output }
       if$
     }
  if$
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  title emphasize latinize colorize "title" output.check
  new.block
  "\textgreek{Didaktorik'h Diatrib'h}" format.thesis.type
                                        latinize output.nonnull
  school latinize "school" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {gr-phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  title emphasize colorize "title" output.check
  new.block
  "\textgreek{Didaktorik'h Diatrib'h}" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization latinize output }
    { format.editors latinize output.nonnull }
  if$
  new.block
  title emphasize latinize colorize "title" output.check
  format.bvolume output
  format.number.series latinize output
  address empty$
    { editor empty$
    { publisher new.sentence.checka }
    { organization publisher new.sentence.checkb
      organization latinize output
    }
      if$
      publisher latinize output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date latinize "year" output.check
      new.sentence
      editor empty$
    'skip$
    { organization latinize output }
      if$
      publisher latinize output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {gr-proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  title emphasize colorize "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
    { publisher new.sentence.checka }
    { organization publisher new.sentence.checkb
      organization output
    }
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
    'skip$
    { organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  format.tr.number output.nonnull
  institution latinize "institution" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {patent}
{ output.bibitem
  format.authors latinize "author" output.check
  new.block
  format.title emphasize latinize colorize "title" output.check
  new.block
  format.patent.number output.nonnull
  institution latinize "institution" output.check
  address latinize output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  foreign-author missing$
     { format.authors "author" output.check }
     { foreign-author format.names latinize output }
  if$
  new.block
  foreign-title missing$
     { format.title emphasize colorize "title" output.check }
     { foreign-title  latinize output }
  if$
  new.block
  note "note" output.check
  format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"Ianou'arioc"}

MACRO {feb} {"Febrou'arioc"}

MACRO {mar} {"M'artioc"}

MACRO {apr} {"Apr'ilioc"}

MACRO {may} {"M'aioc"}

MACRO {jun} {"Io'unioc"}

MACRO {jul} {"Io'ulioc"}

MACRO {aug} {"A'ugoustoc"}

MACRO {sep} {"Sept'embrioc"}

MACRO {oct} {"Okt'wbrioc"}

MACRO {nov} {"No'embrioc"}

MACRO {dec} {"Dek'embrioc"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

MACRO {sigplan} {"ACM SIGPLAN Notices"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
    { "   " * }
    'skip$
      if$
      s nameptr "{vv{ }}{ll{ }}{ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
    { "\textgreek{k.'a.}" * }
    { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
    { "to sort, need author or key in " cite$ * warning$
      ""
    }
    { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
    { key empty$
        { "to sort, need author, editor, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
    { key empty$
        { "to sort, need author, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
    { key empty$
        { "to sort, need editor, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Do not sort bibliography (list by appearance):
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCTION {presort}
%{ type$ "book" =
%  type$ "inbook" =
%  or
%    'author.editor.sort
%    { type$ "proceedings" =
%    'editor.organization.sort
%    { type$ "manual" =
%        'author.organization.sort
%        'author.sort
%      if$
%    }
%      if$
%    }
%  if$
%  "    "
%  *
%  year field.or.null sortify
%  *
%  "    "
%  *
%  title field.or.null
%  sort.format.title
%  *
%  #1 entry.max$ substring$
%  'sort.key$ :=
%}
%
%ITERATE {presort}
%
%SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}