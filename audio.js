/* CCFT Study Guide — Audio Narration v1
 * Browser-native SpeechSynthesis API. Hidden behind feature flag.
 * Enable: ?audio=1 in URL (persists to localStorage) or localStorage.ccft_audio = '1'
 * Disable: ?audio=0 in URL (clears flag + resume) or remove localStorage.ccft_audio
 */
(function(){
  'use strict';

  // ─── Flag handling ─────────────────────────────────────────
  var FLAG_KEY = 'ccft_audio';
  var RESUME_KEY = 'ccft_audio_resume';
  var params = new URLSearchParams(window.location.search);
  if (params.get('audio') === '1') {
    try { localStorage.setItem(FLAG_KEY, '1'); } catch(e){}
  } else if (params.get('audio') === '0') {
    try {
      localStorage.removeItem(FLAG_KEY);
      localStorage.removeItem(RESUME_KEY);
    } catch(e){}
    return; // explicit off — exit
  }
  var enabled = false;
  try { enabled = (localStorage.getItem(FLAG_KEY) === '1'); } catch(e){}
  if (!enabled) return;

  // ─── Capability check ──────────────────────────────────────
  if (!('speechSynthesis' in window) || !('SpeechSynthesisUtterance' in window)) {
    return;
  }
  var synth = window.speechSynthesis;

  // ─── Inject styles ─────────────────────────────────────────
  var css = ''
    + '.ccft-audio-badge{display:inline-block;margin-left:10px;padding:2px 9px;border-radius:10px;'
    + 'background:#b06a00;color:#fff;font-family:Arial,Helvetica,sans-serif;font-size:9.5pt;'
    + 'font-weight:bold;letter-spacing:0.3px;vertical-align:middle;}'
    + '.ccft-listen-btn{display:inline-block;margin-left:10px;padding:3px 11px;border-radius:14px;'
    + 'background:#1b1b1b;color:#fff;font-family:Arial,Helvetica,sans-serif;font-size:10pt;'
    + 'font-weight:bold;border:0;cursor:pointer;vertical-align:middle;letter-spacing:0.2px;'
    + 'line-height:1.45;}'
    + '.ccft-listen-btn:hover{background:#333;}'
    + '.ccft-listen-btn.is-playing{background:#1a5a9a;}'
    + '.ccft-listen-next{display:inline-flex;align-items:center;margin:18px 0 4px;padding:9px 14px;'
    + 'border-radius:8px;background:#f6f6f4;border:1px solid #e0e0e0;color:#1a5a9a;'
    + 'font-family:Arial,Helvetica,sans-serif;font-size:10.5pt;font-weight:bold;cursor:pointer;'
    + 'text-decoration:none;}'
    + '.ccft-listen-next:hover{background:#eef4fb;border-color:#cfe0f2;}'
    + '.ccft-resume-pill{display:flex;align-items:center;gap:10px;margin:0 0 14px;padding:10px 14px;'
    + 'border-radius:8px;background:#eef4fb;border:1px solid #cfe0f2;'
    + 'font-family:Arial,Helvetica,sans-serif;font-size:10.5pt;color:#1a5a9a;}'
    + '.ccft-resume-pill button{background:#1a5a9a;color:#fff;border:0;border-radius:6px;'
    + 'padding:6px 12px;font-weight:bold;cursor:pointer;font-family:inherit;font-size:9.5pt;}'
    + '.ccft-resume-pill .ccft-resume-x{background:transparent;color:#1a5a9a;padding:4px 8px;'
    + 'margin-left:auto;font-size:14pt;line-height:1;}'
    + '.ccft-bar{position:fixed;left:0;right:0;bottom:0;z-index:100;display:none;align-items:center;'
    + 'gap:14px;padding:10px 18px;min-height:60px;'
    + 'background:rgba(27,27,27,0.92);color:#fff;'
    + '-webkit-backdrop-filter:blur(8px);backdrop-filter:blur(8px);'
    + 'font-family:Arial,Helvetica,sans-serif;font-size:11pt;'
    + 'box-shadow:0 -4px 20px rgba(0,0,0,0.25);}'
    + '.ccft-bar.is-active{display:flex;}'
    + '.ccft-bar button{background:transparent;color:#fff;border:1px solid rgba(255,255,255,0.4);'
    + 'border-radius:50%;width:34px;height:34px;cursor:pointer;font-size:14pt;line-height:1;'
    + 'display:flex;align-items:center;justify-content:center;padding:0;flex:none;}'
    + '.ccft-bar button:hover{background:rgba(255,255,255,0.15);}'
    + '.ccft-bar .ccft-bar-title{flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;'
    + 'white-space:nowrap;font-weight:bold;}'
    + '.ccft-bar .ccft-bar-time{font-variant-numeric:tabular-nums;color:#cfcfcf;font-size:10.5pt;'
    + 'flex:none;}'
    + '.ccft-bar .ccft-bar-speed{display:flex;align-items:center;gap:6px;flex:none;}'
    + '.ccft-bar .ccft-bar-speed label{color:#cfcfcf;font-size:10pt;}'
    + '.ccft-bar .ccft-bar-speed input{width:90px;cursor:pointer;}'
    + '.ccft-bar .ccft-bar-speed-val{color:#fff;font-size:10pt;min-width:32px;text-align:right;'
    + 'font-variant-numeric:tabular-nums;}'
    + '.ccft-bar .ccft-bar-close{border-color:rgba(255,255,255,0.3);}'
    + '@media (max-width:640px){'
    + '.ccft-bar{gap:8px;padding:8px 12px;flex-wrap:wrap;}'
    + '.ccft-bar .ccft-bar-title{order:-1;width:100%;flex:none;}'
    + '.ccft-bar .ccft-bar-speed input{width:70px;}'
    + '}';
  var styleEl = document.createElement('style');
  styleEl.textContent = css;
  document.head.appendChild(styleEl);

  // ─── Voice selection ───────────────────────────────────────
  var voices = [];
  var preferredVoice = null;
  function loadVoices(){
    voices = synth.getVoices() || [];
    if (!voices.length) return false;
    // Prefer Samantha (Apple), then any en-US, then any en-*
    preferredVoice = voices.find(function(v){ return v.name === 'Samantha'; })
      || voices.find(function(v){ return /^en[-_]US/i.test(v.lang) && /female|samantha|victoria|allison|ava/i.test(v.name); })
      || voices.find(function(v){ return /^en[-_]US/i.test(v.lang); })
      || voices.find(function(v){ return /^en/i.test(v.lang); })
      || voices[0];
    return true;
  }
  loadVoices();
  if (typeof synth.onvoiceschanged !== 'undefined') {
    synth.onvoiceschanged = function(){ loadVoices(); };
  }

  // ─── Utilities ─────────────────────────────────────────────
  function slugify(s){
    return (s || '').toLowerCase().trim()
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .slice(0, 60) || ('s-' + Math.random().toString(36).slice(2,8));
  }
  function fmtTime(sec){
    sec = Math.max(0, Math.floor(sec || 0));
    var m = Math.floor(sec / 60), s = sec % 60;
    return m + ':' + (s < 10 ? '0' : '') + s;
  }

  // Extract clean readable text from a section (exclude nav, buttons, footnote markers)
  function extractText(sectionEl){
    var clone = sectionEl.cloneNode(true);
    // Remove things we don't want narrated
    var rm = clone.querySelectorAll(
      '.ccft-listen-btn, .ccft-listen-next, .ccft-audio-badge, '
      + 'button, svg, nav, .jump, .appbar, .fab-top, '
      + '.hunt-check, .pdf-link, .ch-file, .ch-tier, .back-top, '
      + '.q-ans summary'
    );
    rm.forEach(function(el){ el.remove(); });
    // Replace block tags with newlines so sentences don't fuse
    var blocks = clone.querySelectorAll('p, li, h1, h2, h3, h4, dt, dd, div');
    blocks.forEach(function(el){
      el.appendChild(document.createTextNode('. '));
    });
    var text = clone.textContent || '';
    // Normalize whitespace and stray punctuation
    text = text.replace(/\s+/g, ' ')
      .replace(/\s*\.\s*\.\s*/g, '. ')
      .replace(/\s+([,.;:!?])/g, '$1')
      .replace(/\.\s*\./g, '.')
      .trim();
    return text;
  }

  // Split text into words for offset tracking
  function getWords(text){
    return text.split(/(\s+)/); // keep separators so charIndex maps
  }
  function wordIndexFromChar(text, charIndex){
    if (!charIndex || charIndex <= 0) return 0;
    var slice = text.slice(0, charIndex);
    var m = slice.match(/\S+/g);
    return m ? m.length - 1 : 0;
  }
  function textFromWordOffset(text, wordOffset){
    if (!wordOffset || wordOffset <= 0) return text;
    var parts = text.match(/\S+/g) || [];
    if (wordOffset >= parts.length) return text;
    // Find char index of the wordOffset-th word
    var count = 0, i = 0;
    while (i < text.length && count < wordOffset) {
      // skip whitespace
      while (i < text.length && /\s/.test(text[i])) i++;
      if (count === wordOffset) break;
      // skip word
      while (i < text.length && !/\s/.test(text[i])) i++;
      count++;
    }
    return text.slice(i);
  }

  // ─── Resume state ──────────────────────────────────────────
  function saveResume(data){
    try { localStorage.setItem(RESUME_KEY, JSON.stringify(data)); } catch(e){}
  }
  function loadResume(){
    try {
      var raw = localStorage.getItem(RESUME_KEY);
      if (!raw) return null;
      return JSON.parse(raw);
    } catch(e){ return null; }
  }
  function clearResume(){
    try { localStorage.removeItem(RESUME_KEY); } catch(e){}
  }

  // ─── Section discovery ────────────────────────────────────
  function findSections(){
    var nodes = document.querySelectorAll('article.chapter, section.chapter, section.domain');
    var sections = [];
    nodes.forEach(function(node){
      var h = node.querySelector('.ch-title, .domain-head h2, h2, h3');
      if (!h) return;
      var title = (h.textContent || '').replace(/\s+/g, ' ').trim();
      if (!title) return;
      if (!node.id) node.id = 'sec-' + slugify(title);
      sections.push({ el: node, headingEl: h, id: node.id, title: title });
    });
    return sections;
  }

  // ─── Audio bar ─────────────────────────────────────────────
  var bar, barTitle, barTime, barPlayBtn, barSpeedSlider, barSpeedVal;
  var SPEEDS = [0.75, 1, 1.25, 1.5, 1.75, 2];
  function buildBar(){
    bar = document.createElement('div');
    bar.className = 'ccft-bar';
    bar.setAttribute('role', 'region');
    bar.setAttribute('aria-label', 'Audio player');
    bar.innerHTML = ''
      + '<button type="button" class="ccft-bar-play" aria-label="Pause">&#10074;&#10074;</button>'
      + '<div class="ccft-bar-title"></div>'
      + '<div class="ccft-bar-time">0:00</div>'
      + '<div class="ccft-bar-speed">'
      +   '<label for="ccft-speed">Speed</label>'
      +   '<input id="ccft-speed" type="range" min="0" max="5" step="1" value="1">'
      +   '<span class="ccft-bar-speed-val">1.0&times;</span>'
      + '</div>'
      + '<button type="button" class="ccft-bar-close" aria-label="Close audio">&times;</button>';
    document.body.appendChild(bar);
    barTitle = bar.querySelector('.ccft-bar-title');
    barTime = bar.querySelector('.ccft-bar-time');
    barPlayBtn = bar.querySelector('.ccft-bar-play');
    barSpeedSlider = bar.querySelector('#ccft-speed');
    barSpeedVal = bar.querySelector('.ccft-bar-speed-val');

    barPlayBtn.addEventListener('click', togglePlayPause);
    bar.querySelector('.ccft-bar-close').addEventListener('click', stopAndClose);
    barSpeedSlider.addEventListener('input', function(){
      var idx = parseInt(barSpeedSlider.value, 10) || 1;
      var rate = SPEEDS[idx] || 1;
      state.rate = rate;
      barSpeedVal.textContent = rate.toFixed(2).replace(/0$/, '') + '×';
      // Restart from current word offset with new rate
      if (state.section && (state.playing || state.paused)) {
        restartFromOffset();
      }
    });
  }
  function showBar(){ if (bar) bar.classList.add('is-active'); }
  function hideBar(){ if (bar) bar.classList.remove('is-active'); }
  function setPlayIcon(playing){
    if (!barPlayBtn) return;
    if (playing) {
      barPlayBtn.innerHTML = '&#10074;&#10074;';
      barPlayBtn.setAttribute('aria-label', 'Pause');
    } else {
      barPlayBtn.innerHTML = '&#9654;';
      barPlayBtn.setAttribute('aria-label', 'Play');
    }
  }

  // ─── Playback state ───────────────────────────────────────
  var state = {
    section: null,
    text: '',
    wordOffset: 0,
    rate: 1,
    utterance: null,
    playing: false,
    paused: false,
    startedAt: 0,
    elapsedBeforeRestart: 0,
    timer: null,
    saveTick: 0
  };

  function tickTime(){
    if (!state.section) return;
    var now = Date.now();
    var totalSec = state.elapsedBeforeRestart + (state.playing ? (now - state.startedAt)/1000 : 0);
    if (barTime) barTime.textContent = fmtTime(totalSec);
  }

  function startTimer(){
    stopTimer();
    state.timer = setInterval(function(){
      tickTime();
      // Throttle resume save to ~2s
      state.saveTick = (state.saveTick || 0) + 1;
      if (state.saveTick >= 4) { // 4 * 500ms = 2s
        state.saveTick = 0;
        persistResume();
      }
    }, 500);
  }
  function stopTimer(){
    if (state.timer) { clearInterval(state.timer); state.timer = null; }
  }

  function persistResume(){
    if (!state.section) return;
    saveResume({
      section_id: state.section.id,
      word_offset: state.wordOffset,
      voice_name: preferredVoice ? preferredVoice.name : null,
      speed: state.rate,
      timestamp: Date.now(),
      section_title: state.section.title,
      page: window.location.pathname
    });
  }

  function buildUtterance(text){
    var u = new SpeechSynthesisUtterance(text);
    if (preferredVoice) u.voice = preferredVoice;
    u.rate = state.rate || 1;
    u.pitch = 1;
    u.volume = 1;
    u.lang = (preferredVoice && preferredVoice.lang) || 'en-US';
    u.onboundary = function(ev){
      if (ev.name && ev.name !== 'word') return;
      var charIdx = ev.charIndex || 0;
      var wordsBefore = wordIndexFromChar(text, charIdx);
      state.wordOffset = (state.baseWordOffset || 0) + wordsBefore;
    };
    u.onend = function(){
      if (state.suppressEnd) { state.suppressEnd = false; return; }
      handleSectionEnd();
    };
    u.onerror = function(ev){
      // Common: 'canceled' is benign during restarts. Others we log and stop.
      if (ev && ev.error === 'canceled') return;
      if (ev && ev.error === 'interrupted') return;
    };
    return u;
  }

  function startSpeak(section, wordOffset){
    state.section = section;
    state.text = extractText(section.el);
    state.wordOffset = wordOffset || 0;
    state.baseWordOffset = state.wordOffset;
    state.elapsedBeforeRestart = 0;
    state.startedAt = Date.now();
    state.playing = true;
    state.paused = false;

    var fromText = textFromWordOffset(state.text, state.wordOffset);
    state.utterance = buildUtterance(fromText);

    // Mark active listen button
    document.querySelectorAll('.ccft-listen-btn').forEach(function(b){
      b.classList.toggle('is-playing', b.getAttribute('data-section-id') === section.id);
      if (b.getAttribute('data-section-id') === section.id) {
        b.setAttribute('aria-pressed', 'true');
      } else {
        b.setAttribute('aria-pressed', 'false');
      }
    });

    barTitle.textContent = section.title;
    setPlayIcon(true);
    showBar();
    try { synth.cancel(); } catch(e){}
    // Tiny defer — some browsers race cancel vs speak
    setTimeout(function(){
      try { synth.speak(state.utterance); } catch(e){}
    }, 30);
    startTimer();
    persistResume();
  }

  function restartFromOffset(){
    if (!state.section) return;
    state.suppressEnd = true;
    try { synth.cancel(); } catch(e){}
    var wasPaused = state.paused;
    state.elapsedBeforeRestart += (Date.now() - state.startedAt)/1000;
    var fromText = textFromWordOffset(state.text, state.wordOffset);
    state.baseWordOffset = state.wordOffset;
    state.utterance = buildUtterance(fromText);
    state.startedAt = Date.now();
    state.playing = !wasPaused;
    state.paused = wasPaused;
    setTimeout(function(){
      state.suppressEnd = false;
      try { synth.speak(state.utterance); } catch(e){}
      if (wasPaused) {
        try { synth.pause(); } catch(e){}
      }
    }, 40);
  }

  function togglePlayPause(){
    if (!state.section) return;
    if (state.playing) {
      // Try native pause
      try { synth.pause(); } catch(e){}
      state.playing = false;
      state.paused = true;
      state.elapsedBeforeRestart += (Date.now() - state.startedAt)/1000;
      stopTimer();
      setPlayIcon(false);
      // iOS Safari fallback: if synth still says speaking, attempt cancel+restart on resume
    } else if (state.paused) {
      // Resume
      var resumed = false;
      try {
        synth.resume();
        resumed = synth.speaking;
      } catch(e){}
      if (!resumed) {
        // iOS fallback: restart from word offset
        restartFromOffset();
      } else {
        state.playing = true;
        state.paused = false;
        state.startedAt = Date.now();
        setPlayIcon(true);
        startTimer();
      }
    }
  }

  function handleSectionEnd(){
    stopTimer();
    state.playing = false;
    state.paused = false;
    setPlayIcon(true);
    // Inject "Listen to next section" link
    var sections = window.__ccftSections || [];
    var idx = sections.findIndex(function(s){ return s.id === state.section.id; });
    var nextSec = (idx >= 0 && idx + 1 < sections.length) ? sections[idx + 1] : null;
    if (state.section && nextSec) {
      // Remove any prior next-link in this section
      var prior = state.section.el.querySelector('.ccft-listen-next');
      if (prior) prior.remove();
      var nextBtn = document.createElement('a');
      nextBtn.className = 'ccft-listen-next';
      nextBtn.href = '#' + nextSec.id;
      nextBtn.textContent = '▶  Listen to next section: ' + nextSec.title;
      nextBtn.addEventListener('click', function(ev){
        ev.preventDefault();
        // Scroll into view then play
        document.getElementById(nextSec.id).scrollIntoView({behavior:'smooth', block:'start'});
        setTimeout(function(){ startSpeak(nextSec, 0); }, 200);
      });
      state.section.el.appendChild(nextBtn);
    }
    // Clear active marker on buttons
    document.querySelectorAll('.ccft-listen-btn').forEach(function(b){
      b.classList.remove('is-playing');
      b.setAttribute('aria-pressed', 'false');
    });
    hideBar();
    clearResume();
    state.section = null;
    state.text = '';
    state.wordOffset = 0;
  }

  function stopAndClose(){
    state.suppressEnd = true;
    try { synth.cancel(); } catch(e){}
    stopTimer();
    state.playing = false;
    state.paused = false;
    state.section = null;
    state.text = '';
    state.wordOffset = 0;
    document.querySelectorAll('.ccft-listen-btn').forEach(function(b){
      b.classList.remove('is-playing');
      b.setAttribute('aria-pressed', 'false');
    });
    hideBar();
    clearResume();
    setTimeout(function(){ state.suppressEnd = false; }, 100);
  }

  // ─── Inject Listen buttons + badge + resume pill ─────────
  function injectButtons(){
    var sections = findSections();
    window.__ccftSections = sections;
    sections.forEach(function(s){
      // Skip if already has button
      if (s.headingEl.querySelector('.ccft-listen-btn')) return;
      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'ccft-listen-btn';
      btn.setAttribute('data-section-id', s.id);
      btn.setAttribute('aria-pressed', 'false');
      btn.innerHTML = '▶ Listen';
      btn.addEventListener('click', function(){
        if (state.section && state.section.id === s.id && (state.playing || state.paused)) {
          // Toggle pause/play on same section
          togglePlayPause();
        } else {
          startSpeak(s, 0);
        }
      });
      s.headingEl.appendChild(btn);
    });

    // Badge in brand area
    var brand = document.querySelector('.appbar .brand') || document.querySelector('.masthead h1');
    if (brand && !brand.querySelector('.ccft-audio-badge')) {
      var badge = document.createElement('span');
      badge.className = 'ccft-audio-badge';
      badge.textContent = 'Audio beta';
      brand.appendChild(badge);
    }
  }

  function injectResumePill(){
    var data = loadResume();
    if (!data || !data.section_id) return;
    // Only show on the same page
    if (data.page && data.page !== window.location.pathname) return;
    var target = document.getElementById(data.section_id);
    if (!target) return;
    var wrap = document.querySelector('.wrap') || document.body;
    var pill = document.createElement('div');
    pill.className = 'ccft-resume-pill';
    pill.innerHTML = ''
      + '<span>⏯ Resume listening from <strong></strong></span>'
      + '<button type="button" class="ccft-resume-go">Resume</button>'
      + '<button type="button" class="ccft-resume-x" aria-label="Dismiss resume">&times;</button>';
    pill.querySelector('strong').textContent = data.section_title || 'previous section';
    pill.querySelector('.ccft-resume-go').addEventListener('click', function(){
      var sec = (window.__ccftSections || []).find(function(s){ return s.id === data.section_id; });
      if (!sec) return;
      document.getElementById(data.section_id).scrollIntoView({behavior:'smooth', block:'start'});
      // Restore rate
      var rateIdx = SPEEDS.indexOf(data.speed);
      if (rateIdx >= 0) {
        state.rate = data.speed;
        barSpeedSlider.value = String(rateIdx);
        barSpeedVal.textContent = data.speed.toFixed(2).replace(/0$/, '') + '×';
      }
      setTimeout(function(){ startSpeak(sec, data.word_offset || 0); }, 250);
      pill.remove();
    });
    pill.querySelector('.ccft-resume-x').addEventListener('click', function(){
      clearResume();
      pill.remove();
    });
    // Insert at top of wrap
    var firstChild = wrap.firstChild;
    wrap.insertBefore(pill, firstChild);
  }

  // ─── Init ──────────────────────────────────────────────────
  function init(){
    buildBar();
    injectButtons();
    injectResumePill();
    // Stop audio on page unload
    window.addEventListener('beforeunload', function(){
      try { synth.cancel(); } catch(e){}
    });
    // iOS Safari workaround: speechSynthesis pauses on tab blur — re-kick on focus
    document.addEventListener('visibilitychange', function(){
      if (document.visibilityState === 'visible' && state.playing && !synth.speaking && state.section) {
        // Restart from current word offset
        restartFromOffset();
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
