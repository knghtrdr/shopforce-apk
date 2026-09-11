/**
 * Marketing Cloud Einstein Collect.js helper.
 * Paste your Collect MID / script URL in the site config panel.
 * Email must match the ShopForce app Contact Key for journeys.
 */
window._etmc = window._etmc || [];

function cfg() {
  return window.ShopForce ? window.ShopForce.getCfg() : {};
}

function ensureCollect() {
  const c = cfg();
  const mid = (c.mid || '').trim();
  const scriptUrl = (c.scriptUrl || '').trim() || (mid ? `https://${mid}.collect.igodigital.com/collect.js` : '');
  if (!scriptUrl || document.querySelector('script[data-sfmc-collect]')) return;
  const s = document.createElement('script');
  s.src = scriptUrl;
  s.async = true;
  s.dataset.sfmcCollect = '1';
  document.head.appendChild(s);
  if (mid) {
    window._etmc.push(['setOrgId', mid]);
  }
  if (c.email) {
    window._etmc.push(['setUserInfo', { email: c.email }]);
  }
}

function identify() {
  ensureCollect();
  const c = cfg();
  if (c.mid) window._etmc.push(['setOrgId', c.mid]);
  if (c.email) window._etmc.push(['setUserInfo', { email: c.email }]);
}

function trackPageView(itemId) {
  identify();
  if (itemId) window._etmc.push(['trackPageView', { item: itemId }]);
  else window._etmc.push(['trackPageView']);
}

function trackCart(items) {
  identify();
  window._etmc.push([
    'trackCart',
    {
      cart: (items || []).map((i) => ({
        item: i.id,
        unique_id: i.id,
        name: i.name,
        price: String(i.price),
        quantity: String(i.quantity),
      })),
    },
  ]);
}

function trackConversion(items, orderNumber) {
  identify();
  window._etmc.push([
    'trackConversion',
    {
      cart: (items || []).map((i) => ({
        item: i.id,
        unique_id: i.id,
        name: i.name,
        price: String(i.price),
        quantity: String(i.quantity),
      })),
      order_number: orderNumber,
    },
  ]);
}

window.ShopCollect = { ensureCollect, identify, trackPageView, trackCart, trackConversion };
