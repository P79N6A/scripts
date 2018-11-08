
function isElementVisible(el) {
  var rect     = el.getBoundingClientRect(),
    vWidth   = window.innerWidth || doc.documentElement.clientWidth,
    vHeight  = window.innerHeight || doc.documentElement.clientHeight,
    efp      = function (x, y) { return document.elementFromPoint(x, y) };

  // Return false if it's not in the viewport
  if (rect.right < 0 || rect.bottom < 0
    || rect.left > vWidth || rect.top > vHeight)
    return false;

  // Return true if any of its four corners are visible
  return (
    el.contains(efp(rect.left,  rect.top))
    ||  el.contains(efp(rect.right, rect.top))
    ||  el.contains(efp(rect.right, rect.bottom))
    ||  el.contains(efp(rect.left,  rect.bottom))
  );
}

(function () {
  if (/^https:\/\/github.com\/.+\/.+\/(issues|pull)\/.+/.test(location.href)) {
    window.addEventListener('keydown', (e) => {
      if (e.keyCode === 69 && e.shiftKey && e.altKey && e.ctrlKey && e.metaKey) {
        const els = document.querySelectorAll('button.js-comment-edit-button');
        for (let el of els) {
          const node = el.parentNode.parentNode;
          if (isElementVisible(node)) {
            el.click();
            return;
          }
        }
        els[0].click();
      }
    })
  }
})();