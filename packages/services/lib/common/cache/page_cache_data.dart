import 'dart:developer';

// TICKET缓存的列表为:
// /api/ticket_bet/app/v1/info
// /api/ticket/app/v1/list
// /api/ticket_help/app/v1/info
// /api/ticket/app/v1/getGameCodeList
// /api/ticket/app/v1/getLiveGameList
// /api/ticket/app/v1/list
//
// ADV_SLIDE 缓存的列表为:
// /api/advNotice/pc/v1/getAll
// /api/advNotice/app/v1/getAll
// 前端应该一次获取ALL就行 不需要调用 其他的 /getByTypes /getByTypec

class PageCacheItem {
  String key = "";
  List<String> items = [];

  pageCacheItem() {
    log("cacheItem init");
  }
}

class PageCacheList {
  final List<PageCacheItem> _items = [];

  PageCacheList() {
    PageCacheItem ticketItem = PageCacheItem();


    // test
    ticketItem.items.add("/api/sys/v1/getPublicConfig");

    ticketItem.key = "TICKET";
    ticketItem.items.add("/api/ticket_bet/app/v1/info");
    ticketItem.items.add("/api/ticket/app/v1/list");
    ticketItem.items.add("/api/ticket_help/app/v1/info");
    ticketItem.items.add("/api/ticket/app/v1/getGameCodeList");
    ticketItem.items.add("/api/ticket/app/v1/getLiveGameList");
    ticketItem.items.add("/api/ticket/app/v1/list");


    PageCacheItem advSlideItem = PageCacheItem();
    advSlideItem.key = "ADV_SLIDE";
    advSlideItem.items.add("/api/advNotice/pc/v1/getAll");
    advSlideItem.items.add("/api/advNotice/app/v1/getAll");

    _items.add(ticketItem);
    _items.add(advSlideItem);
  }

  String getKey(String path) {
    for (final item in _items) {
      for (final obj in item.items) {
        if (path == obj) {
          return item.key;
        }
      }
    }
    return "";
  }
}
