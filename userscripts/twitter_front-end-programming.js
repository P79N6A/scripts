
// from npm pkg: on-change
function onChange(object, onChange) {
  const handler = {
    get(target, property, receiver) {
      if (property === 'toJSON') {
        return () => {
          console.log('t', target, JSON.stringify(target));
          return target;
        };
      }
      try {
        return new Proxy(target[property], handler);
      } catch (err) {
        return Reflect.get(target, property, receiver);
      }
    },
    defineProperty(target, property, descriptor) {
      onChange();
      return Reflect.defineProperty(target, property, descriptor);
    },
    deleteProperty(target, property) {
      onChange();
      return Reflect.deleteProperty(target, property);
    }
  };
  return new Proxy(object, handler);
}

const KEY = 't_highlight_timeline_fep';
const initialStore = JSON.parse(localStorage.getItem(KEY) || '{}');
const store = onChange(initialStore, () => {
  console.log(`[DEBUG] store is changed: ${JSON.stringify(store)}`);
  localStorage.setItem(KEY, JSON.stringify(store));
});

function mark(els) {
  els.forEach(markEl);
}

function markEl(el) {
  const aEls = el.querySelectorAll('a');
  // e.g.
  // url: https://mobile.twitter.com/thejameskyle/status/959057233672732672
  // key: 959057233672732672
  if (!aEls[2]) {
    console.error(`el ${el} can't resolve the href with aEl[2]`);
    return;
  }
  const url = aEls[2].href;
  const key = url.match(/\/(\d+)$/)[1];
  if (!store[key]) {
    console.log(`[DEBUG] ${key} is not in store`, el);
    highlightEl(el);
    store[key] = 1;
  }
}

function highlightEl(el) {
  el.style.background = '#f6ff00';
}

function log(msg) {
  GM_log(`[TWITTRE_FEP] ${msg}`);
}

function init() {
  const el = document.querySelector('main section > div > div > div');
  if (!el) {
    setTimeout(init, 500);
    return;
  }
  const observer = new MutationObserver((list) => {
    // 找到所有 type 为 childList 的 addedNodes 列表
    // const els = list.reduce((memo, item) => {
    //   if (item.type === 'childList' && item.addedNodes && item.addedNodes.length) {
    //     memo = [...memo, ...item.addedNodes];
    //   }
    //   return memo;
    // }, []);
    let els = el.children;
    els = [...els].filter(el => {
      return el.className === els[0].className;
    });
    console.log(`[DEBUG] ${els.length} els added`);
    mark(els);
  });
  observer.observe(el, {
    childList: true,
  });

  const initialEls = document.querySelectorAll('main section > div > div > div > div');
  console.log(`[DEBUG] ${initialEls.length} initial els found`);
  mark(initialEls);
}

if (location.href === 'https://mobile.twitter.com/i/timeline') {
  init();
}
