import 'dart:convert';

import 'package:core/core.dart';

class Novel {
  Novel({required this.title, required this.cover, required this.url});

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      title: json['title'] as String,
      cover: json['cover'] as String,
      url: json['url'] as String,
    );
  }

  final String title;
  final String cover;
  final String url;
}

class $TempData {
  List<Novel> _jsonToNovels(String rawJson) {
    final rawNovels = (json.decode(rawJson) as List).cast<DataMap>();

    return rawNovels.map(Novel.fromJson).toList();
  }

  List<Novel> getListOne() {
    const rawJson =
        '''[{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01660-a-regressors-tale-of-cultivation.jpg","title":"A Regressor’s Tale of Cultivation","url":"https://www.lightnovelworld.com/novel/a-regressors-tale-of-cultivation"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01652-naruto-the-wind-calamity.jpg?v=03120902","title":"Naruto: The Wind Calamity","url":"https://www.lightnovelworld.com/novel/naruto-the-wind-calamity"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01646-kill-the-sun.jpg","title":"Kill the Sun","url":"https://www.lightnovelworld.com/novel/kill-the-sun-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01648-ill-surpass-the-mc.jpg?v=03111041","title":"I'll Surpass The MC","url":"https://www.lightnovelworld.com/novel/ill-surpass-the-mc-05122225"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01655-i-was-mistaken-as-a-monstrous-genius-actor.jpg","title":"I Was Mistaken as a Monstrous Genius Actor","url":"https://www.lightnovelworld.com/novel/i-was-mistaken-as-a-monstrous-genius-actor"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01644-arcane-academy-the-divine-extraction-legacy.jpg","title":"Arcane Academy: The Divine Extraction Legacy","url":"https://www.lightnovelworld.com/novel/arcane-academy-the-divine-extraction-legacy-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01643-from-thug-to-idol-transmigrating-to-a-survival-show.jpg","title":"From Thug to Idol: Transmigrating to a Survival Show","url":"https://www.lightnovelworld.com/novel/from-thug-to-idol-transmigrating-to-a-survival-show-05122221"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01650-magics-return-i-can-see-the-spirits.jpg","title":"Magic's Return: I Can See The Spirits","url":"https://www.lightnovelworld.com/novel/magics-return-i-can-see-the-spirits-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01649-taking-the-mafia-to-the-magic-world.jpg","title":"Taking the Mafia to the Magic World","url":"https://www.lightnovelworld.com/novel/taking-the-mafia-to-the-magic-world-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01657-the-martial-god-who-regressed-back-to-level-2.jpg","title":"The Martial God who Regressed Back to Level 2","url":"https://www.lightnovelworld.com/novel/the-martial-god-who-regressed-back-to-level-2"}]''';

    return _jsonToNovels(rawJson);
  }

  List<Novel> getListTwo() {
    const rawJson =
        '''[{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00736-the-return-of-the-god-level-assassin-novel.jpg","title":"The Return Of The God Level Assassin (WN)","url":"https://www.lightnovelworld.com/novel/the-return-of-the-god-level-assassin-lnw-16091325"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01491-system-vs-rebirth.jpg","title":"System vs Rebirth","url":"https://www.lightnovelworld.com/novel/system-vs-rebirth-05122227"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01502-vile-evil-hides-under-the-veil.jpg","title":"Vile Evil Hides Under The Veil","url":"https://www.lightnovelworld.com/novel/vile-evil-hides-under-the-veil-27061852"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00709-reincarnated-as-a-fox-with-system-novel.jpg","title":"Reincarnated As A Fox With System (WN)","url":"https://www.lightnovelworld.com/novel/reincarnated-as-a-fox-with-system-novel-16091311"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01103-the-oracle-paths.jpg","title":"The Oracle Paths","url":"https://www.lightnovelworld.com/novel/the-oracle-paths-wn-05122223"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01450-walker-of-the-worlds.jpg","title":"Walker Of The Worlds","url":"https://www.lightnovelworld.com/novel/walker-of-the-worlds-16091325"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01503-stealing-spree.jpg","title":"Stealing Spree","url":"https://www.lightnovelworld.com/novel/stealing-spree-17122006"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01603-cursed-immortality.jpg","title":"Cursed Immortality","url":"https://www.lightnovelworld.com/novel/cursed-immortality-16091347"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00596-monster-integration-web-novel.jpg","title":"Monster Integration (Web Novel)","url":"https://www.lightnovelworld.com/novel/monster-integration-web-novel-16091309"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01636-the-primordial-record.jpg","title":"The Primordial Record","url":"https://www.lightnovelworld.com/novel/the-primordial-record-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01283-villain-retirement.jpg?v=30041127","title":"Villain Retirement","url":"https://www.lightnovelworld.com/novel/villain-retirement-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01323-divine-path-system.jpg","title":"Divine Path System","url":"https://www.lightnovelworld.com/novel/divine-path-system-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01452-eternal-cultivation-of-alchemy.jpg","title":"Eternal Cultivation of Alchemy","url":"https://www.lightnovelworld.com/novel/eternal-cultivation-of-alchemy-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01613-why-should-i-stop-being-a-villain.jpg","title":"Why Should I Stop Being a Villain","url":"https://www.lightnovelworld.com/novel/why-should-i-stop-being-a-villain-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01615-village-heads-debauchery.jpg","title":"Village Head's Debauchery","url":"https://www.lightnovelworld.com/novel/village-heads-debauchery-16091308"}]''';

    return _jsonToNovels(rawJson);
  }

  List<Novel> getListThree() {
    const rawJson =
        '''[{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01365-shadow-slave.jpg","title":"Shadow Slave","url":"https://www.lightnovelworld.com/novel/shadow-slave-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00275-lord-of-the-mysteries-wn.jpg","title":"Lord of the Mysteries (Web Novel)","url":"https://www.lightnovelworld.com/novel/lord-of-the-mysteries-wn-16091313"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00172-reverend-insanity.jpg","title":"Reverend Insanity","url":"https://www.lightnovelworld.com/novel/reverend-insanity-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01268-the-primal-hunter.jpg","title":"The Primal Hunter","url":"https://www.lightnovelworld.com/novel/the-primal-hunter-05122221"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01113-cultivation-online.jpg","title":"Cultivation Online","url":"https://www.lightnovelworld.com/novel/cultivation-online-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01398-supreme-harem-god-system.jpg","title":"Supreme Harem God System","url":"https://www.lightnovelworld.com/novel/supreme-harem-god-system-05122221"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01238-the-authors-pov.jpg?v=18071011","title":"The Author's POV","url":"https://www.lightnovelworld.com/novel/the-authors-pov-05122222"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00707-my-vampire-system-wnovel.jpg","title":"My Vampire System (WN)","url":"https://www.lightnovelworld.com/novel/my-vampire-system-novel-16091351"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01377-sword-god-in-a-world-of-magic.jpg","title":"Sword God in a World of Magic","url":"https://www.lightnovelworld.com/novel/sword-god-in-a-world-of-magic-05122221"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00548-the-beginning-after-the-end.jpg","title":"The Beginning After The End (Web Novel)","url":"https://www.lightnovelworld.com/novel/the-beginning-after-the-end-web-novel-11110049"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01660-a-regressors-tale-of-cultivation.jpg","title":"A Regressor’s Tale of Cultivation","url":"https://www.lightnovelworld.com/novel/a-regressors-tale-of-cultivation"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00245-the-legendary-mechanic-novel.jpg","title":"The Legendary Mechanic (WN)","url":"https://www.lightnovelworld.com/novel/the-legendary-mechanic-novel-05122221"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/01132-supremacy-games.jpg?v=18071009","title":"Supremacy Games","url":"https://www.lightnovelworld.com/novel/supremacy-games-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00732-infinite-mana-in-the-apocalypse-novel.jpg","title":"Infinite Mana In The Apocalypse (WN)","url":"https://www.lightnovelworld.com/novel/infinite-mana-in-the-apocalypse-novel-05122224"},{"cover":"https://static.lightnovelworld.com/bookcover/158x210/00016-reincarnation-of-the-strongest-sword-god-novel.jpg","title":"Reincarnation Of The Strongest Sword God (Web Novel)","url":"https://www.lightnovelworld.com/novel/reincarnation-of-the-strongest-sword-god-lnv-05122222"}]''';

    return _jsonToNovels(rawJson);
  }
}