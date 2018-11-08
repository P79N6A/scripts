
function log(msg) {
  GM_log(`[WARN_ME_IF_LANFENG_VACATION] ${msg}`);
}

const STORAGE_KEY = 'LF_VACATION';
// 按小时存，比如：`Tue Jan 09 2018 10:`
const date = new Date().toString().slice(0, 19);

const { date:  settedDate } = JSON.parse(GM_getValue(STORAGE_KEY) || '{}');
log(`setted date: ${settedDate}`);
log(`current date: ${date}`);

if (date.indexOf('Thu Feb 08 2018') === -1 && settedDate !== date) {
  return;
  log('request data');
  GM_xmlhttpRequest({
    method: "GET",
    url: "https://work.alipay-corp.com/nwpipe/u/55162",
    onload: function (res) {
      const text = res.responseText;
      const re = />window\.canaryData\.pageletData\["nw-profile"\].+?\["data"\]\s+=\s+(.+?);window\.canaryData\.pageletData/;
      const m = text.match(re);
      if (m) {
        log('matched');
        const data = JSON.parse(m[1]);
        // 有休假时有 vacationInfo，没休假为 undefined
        const vacationInfo = data.getProfileInfo.content.groups.basic.items.vacationInfo;
        log(`vacationInfo: ${JSON.stringify(vacationInfo)}`);
        if (vacationInfo) {
          alert('haha, vacation');
        }
      } else {
        log('unmatched');
      }

      log('set date');
      GM_setValue(STORAGE_KEY, JSON.stringify({
        date,
      }));
    }
  });
}
