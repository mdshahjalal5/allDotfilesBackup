api.mapkey("<ctrl-y>", "Show me the money", function () {
  Front.showPopup(
    "a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).",
  );
});

//t: an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map("gt", "t");
api.map("t", "T");
api.map("ss", "on");
api.map("aa", "S");
api.map("<Alt-j>", "l");
api.map("<Alt-k>", "h");
api.map("h", "E");
api.map("gj", "G");
api.map("gi", "yy", /.*youtube.*/i);
//api.map("t", "f");
//api.map("f", "t");
api.map("l", "R");
api.lmap("f", "<t>");
api.map("as", ";fs");
api.map("u", "<Ctrl-i>");
api.map("Ctrl+d", "<Ctrl-f>");
api.map("<Ctrl-i>", "<Alt-s>"); // hotkey must be one keystroke with/without modifier, it can not be a sequence of keystrokes like `gg`.
// an example to remove mapkey `Ctrl-i`
api.unmap("<ctrl-i>");
api.map(",", "<Ctrl-6>");
// Add your custom mapping here

api.Hints.setCharacters("asdjkluiopwerm,nhgzxcvq'["); // for right hand  hints will show for now right hands

settings.startToShowEmoji = 1;
//
//
//
//
//
//
//
//
//
//
//
//
//t:  opening function
//
//t: facebook
api.mapkey(
  "sf",
  "Open Facebook",
  function () {
    window.open("https://www.facebook.com", "_blank");
  },
  {
    domain: /./, // Apply this mapping to all domains
  },
);

//t: discord opening
api.mapkey("so", "discord", function () {
  window.open("https://discord.com/channels/@me", "_blank");
});
api.mapkey("ad", "Dotfiles", function () {
  window.open("https://github.com/mdshahjalal5/allDotfilesBackup", "_blank");
});

api.mapkey("ay", "youtube opening", function () {
  window.open("https://www.youtube.com/", "_blank");
});

//t: Open Quran
//
api.mapkey("sq", "Open Quran", function () {
  window.open("https://quran.com", "_blank");
}); //
//
//
//
//
//
//
//
//
//
//
//
//t:https://web.programming-hero.com/level2-batch-4/video/level2-batch-4-1-12-never-unknown-and-nullable-type
api.mapkey("sa", "email inbox opening", function () {
  window.open("https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox", "_blank");
});
api.mapkey("sn", "assignment L2B4Web", function () {
  window.open(
    "https://github.com/orgs/Porgramming-Hero-web-course/repositories",
    "_blank",
  );
});
//t: fbLevel1
api.mapkey("s1", "fbLevel1", function () {
  window.open("https://www.facebook.com/groups/programmingHero", "_blank");
});
//t:L2B4Web
api.mapkey("si", "L2B4Web", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-4/post/level2-batch-4-text-instructions-module-5-",
    "_blank",
  );
});
//t: outline L2B4
api.mapkey("sk", "outline L2B4", function () {
  window.open(
    "https://web.programming-hero.com/66fe345a2037515c16ea6ce7/course-outline",
    "_blank",
  );
});
//t: fbLevel2
api.mapkey("s2", "fbLevel2", function () {
  window.open("https://www.facebook.com/groups/phapollo4", "_blank");
});
//t:L2B4
api.mapkey("s4", "L2B4 typescript module", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-4/video/level2-batch-4-1-12-never-unknown-and-nullable-type",
  );
});
//t: pre requisite
api.mapkey("sp", "pre requisite level2", function () {
  window.open(
    "https://web.programming-hero.com/next-level-prerequisites-batch4/video/next-level-prerequisites-batch4-45-8-active-route-loading-spinner-uselocation-usenavigation",
    "_blank",
  );
});
//t:redux
api.mapkey("sr", "redux", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-1/video/level2-batch-1-21-1-project-initialization-and-redux-store-setup-recap",
    "_blank",
  );
});
//t: open  chatgpt
api.mapkey("sc", "Open chatgpt", function () {
  window.open("https://chatgpt.com/", "_blank");
});

//t: github repository page opening

api.mapkey("gr", "Repository Github", function () {
  window.open("https://github.com/mdshahjalal5?tab=repositories", "_blank");
});

//t:  new repo for github

api.mapkey("gn", "new repo github", function () {
  window.open("https://github.com/new", "_blank");
});
//t:Open blank page
api.mapkey("sb", "Open blank page", function () {
  window.open("https://blank.page/", "_blank");
});
//t:localhost
api.mapkey("sl", "localhost", function () {
  window.open("http://localhost:5173/", "_blank");
});

//t: open whatsApp
api.mapkey("sm", "whatsApp", function () {
  window.open("https://web.whatsapp.com/", "_blank");
});

//
//
//
//
//
//
//
//
//
//
//t: Nasheed and tilawat
//
//
//t: Open Wedding Nasheed
api.mapkey("sj", "Open Wedding Nasheed", function () {
  window.open(
    "https://www.youtube.com/watch?v=dWBgNHT4ipE&ab_channel=HuzaifahNasheeds",
    "_blank",
  );
});
//t: isami music playlist
api.mapkey("su", "isami music playlist", function () {
  window.open(
    "https://www.youtube.com/watch?v=rL6qQ49hBlQ&list=PLXOE5SEv6NpDUSPNxCu1fFTfBi8HZDeJM",
    "_blank",
  );
});
//t: Open 5 Nasheed
api.mapkey("st", "Open 5 Nasheed", function () {
  window.open("https://www.youtube.com/watch?v=naWQJpsbPFM", "_blank");
});
//
//
//
//
//
//
//
//
//
//t:  set theme
// settings.theme = `
// .sk_theme {
//     font-family: Input Sans Condensed, Charcoal, sans-serif;
//     font-size: 10pt;
//     background: #24272e;
//     color: #abb2bf;
// }
// .sk_theme tbody {
//     color: #fff;
// }
// .sk_theme input {
//     color: #d0d0d0;
// }
// .sk_theme .url {
//     color: #61afef;
// }
// .sk_theme .annotation {
//     color: #56b6c2;
// }
// .sk_theme .omnibar_highlight {
//     color: #528bff;
// }
// .sk_theme .omnibar_timestamp {
//     color: #e5c07b;
// }
// .sk_theme .omnibar_visitcount {
//     color: #98c379;
// }
// .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
//     background: #303030;
// }
// .sk_theme #sk_omnibarSearchResult ul li.focused {
//     background: #3e4452;
// }
// #sk_status, #sk_find {
//     font-size: 20pt;
// }`;
//
//
//
//
//
//w: 25/11/2024 12:51 PM Mon GMT+6 Sharifpur, Gazipur, Dhaka
settings.theme = `
.sk_theme {
    font-family: "Input Sans Condensed", Charcoal, sans-serif;
    font-size: 10pt;
    background: #1e1e2e; /* Base */
    color: #cdd6f4; /* Text */
}
.sk_theme tbody {
    color: #f5e0dc; /* Light text */
}
.sk_theme input {
    color: #cdd6f4; /* Input text */
}
.sk_theme .url {
    color: #89b4aa; /* Blue */
}
.sk_theme .annotation {
    color: #f5c2e7; /* Pink */
}
.sk_theme .omnibar_highlight {
    color: #a6e3a1; /* Green */
}
.sk_theme .omnibar_timestamp {
    color: #fab387; /* Peach */
}
.sk_theme .omnibar_visitcount {
    color: #f9e2af; /* Yellow */
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #181825; /* Darker Base */
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #313244; /* Highlight */
}
#sk_status, #sk_find {
    font-size: 20pt;
    background: #1e1e2e; /* Base */
    color: #cdd6f4; /* Text */
}`;
