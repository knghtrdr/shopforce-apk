const CART_KEY = 'shopforce_web_cart';
const CFG_KEY = 'shopforce_collect_cfg';

function money(n) {
  return '₹' + Number(n || 0).toLocaleString('en-IN');
}

function getCfg() {
  try {
    return JSON.parse(localStorage.getItem(CFG_KEY) || '{}');
  } catch {
    return {};
  }
}

function saveCfg(cfg) {
  localStorage.setItem(CFG_KEY, JSON.stringify(cfg));
}

function getCart() {
  try {
    return JSON.parse(localStorage.getItem(CART_KEY) || '[]');
  } catch {
    return [];
  }
}

function saveCart(items) {
  localStorage.setItem(CART_KEY, JSON.stringify(items));
  updateCartCount();
}

function updateCartCount() {
  const el = document.querySelector('[data-cart-count]');
  if (!el) return;
  const n = getCart().reduce((s, i) => s + i.quantity, 0);
  el.textContent = n;
}

function addToCart(product, qty = 1) {
  const cart = getCart();
  const existing = cart.find((i) => i.id === product.id);
  if (existing) existing.quantity += qty;
  else cart.push({ id: product.id, name: product.name, price: product.price, image: product.image, quantity: qty });
  saveCart(cart);
  if (window.ShopCollect) window.ShopCollect.trackCart(cart);
  toast(product.name + ' added to cart');
}

function toast(msg) {
  let el = document.querySelector('.toast');
  if (!el) {
    el = document.createElement('div');
    el.className = 'toast';
    document.body.appendChild(el);
  }
  el.textContent = msg;
  el.style.display = 'block';
  setTimeout(() => { el.style.display = 'none'; }, 2200);
}

async function loadCatalog() {
  const res = await fetch('catalog.json');
  return res.json();
}

function qs(name) {
  return new URLSearchParams(location.search).get(name);
}

function productUrl(id) {
  return 'product.html?id=' + encodeURIComponent(id);
}

function appLink(id) {
  return 'shopforce://product/' + id;
}

function copy(text) {
  navigator.clipboard.writeText(text).then(() => toast('Copied for MobilePush'));
}

window.ShopForce = {
  money, getCfg, saveCfg, getCart, saveCart, addToCart, loadCatalog, qs, productUrl, appLink, copy, updateCartCount, toast,
};
document.addEventListener('DOMContentLoaded', updateCartCount);
