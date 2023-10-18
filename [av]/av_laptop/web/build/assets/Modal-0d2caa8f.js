import{r as s,aa as Ee,n as N,a as E,R as u,al as pt,p as Ce,aP as mt,aQ as ht,o as se,m as R,e as ee,aR as gt,W as yt,X as _t,aS as wt,aT as Ot}from"./index-28ac6c93.js";import{P as Pt}from"./Paper-6c49ea1c.js";import{u as St}from"./use-window-event-a1a40cb7.js";var $=function(){return $=Object.assign||function(t){for(var r,n=1,a=arguments.length;n<a;n++){r=arguments[n];for(var o in r)Object.prototype.hasOwnProperty.call(r,o)&&(t[o]=r[o])}return t},$.apply(this,arguments)};function xe(e,t){var r={};for(var n in e)Object.prototype.hasOwnProperty.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&typeof Object.getOwnPropertySymbols=="function")for(var a=0,n=Object.getOwnPropertySymbols(e);a<n.length;a++)t.indexOf(n[a])<0&&Object.prototype.propertyIsEnumerable.call(e,n[a])&&(r[n[a]]=e[n[a]]);return r}function bt(e,t,r){if(r||arguments.length===2)for(var n=0,a=t.length,o;n<a;n++)(o||!(n in t))&&(o||(o=Array.prototype.slice.call(t,0,n)),o[n]=t[n]);return e.concat(o||Array.prototype.slice.call(t))}var H="right-scroll-bar-position",W="width-before-scroll-bar",$t="with-scroll-bars-hidden",Et="--removed-body-scroll-bar-size";function Ct(e,t){return typeof e=="function"?e(t):e&&(e.current=t),e}function xt(e,t){var r=s.useState(function(){return{value:e,callback:t,facade:{get current(){return r.value},set current(n){var a=r.value;a!==n&&(r.value=n,r.callback(n,a))}}}})[0];return r.callback=t,r.facade}function Rt(e,t){return xt(t||null,function(r){return e.forEach(function(n){return Ct(n,r)})})}function Nt(e){return e}function Bt(e,t){t===void 0&&(t=Nt);var r=[],n=!1,a={read:function(){if(n)throw new Error("Sidecar: could not `read` from an `assigned` medium. `read` could be used only with `useMedium`.");return r.length?r[r.length-1]:e},useMedium:function(o){var i=t(o,n);return r.push(i),function(){r=r.filter(function(l){return l!==i})}},assignSyncMedium:function(o){for(n=!0;r.length;){var i=r;r=[],i.forEach(o)}r={push:function(l){return o(l)},filter:function(){return r}}},assignMedium:function(o){n=!0;var i=[];if(r.length){var l=r;r=[],l.forEach(o),i=r}var f=function(){var p=i;i=[],p.forEach(o)},v=function(){return Promise.resolve().then(f)};v(),r={push:function(p){i.push(p),v()},filter:function(p){return i=i.filter(p),r}}}};return a}function Mt(e){e===void 0&&(e={});var t=Bt(null);return t.options=$({async:!0,ssr:!1},e),t}var Re=function(e){var t=e.sideCar,r=xe(e,["sideCar"]);if(!t)throw new Error("Sidecar: please provide `sideCar` property to import the right car");var n=t.read();if(!n)throw new Error("Sidecar medium not found");return s.createElement(n,$({},r))};Re.isSideCarExport=!0;function It(e,t){return e.useMedium(t),Re}var Ne=Mt(),ne=function(){},te=s.forwardRef(function(e,t){var r=s.useRef(null),n=s.useState({onScrollCapture:ne,onWheelCapture:ne,onTouchMoveCapture:ne}),a=n[0],o=n[1],i=e.forwardProps,l=e.children,f=e.className,v=e.removeScrollBar,p=e.enabled,y=e.shards,m=e.sideCar,_=e.noIsolation,P=e.inert,c=e.allowPinchZoom,d=e.as,w=d===void 0?"div":d,S=e.gapMode,O=xe(e,["forwardProps","children","className","removeScrollBar","enabled","shards","sideCar","noIsolation","inert","allowPinchZoom","as","gapMode"]),b=m,g=Rt([r,t]),C=$($({},O),a);return s.createElement(s.Fragment,null,p&&s.createElement(b,{sideCar:Ne,removeScrollBar:v,shards:y,noIsolation:_,inert:P,setCallbacks:o,allowPinchZoom:!!c,lockRef:r,gapMode:S}),i?s.cloneElement(s.Children.only(l),$($({},C),{ref:g})):s.createElement(w,$({},C,{className:f,ref:g}),l))});te.defaultProps={enabled:!0,removeScrollBar:!0,inert:!1};te.classNames={fullWidth:W,zeroRight:H};var de,jt=function(){if(de)return de;if(typeof __webpack_nonce__<"u")return __webpack_nonce__};function Tt(){if(!document)return null;var e=document.createElement("style");e.type="text/css";var t=jt();return t&&e.setAttribute("nonce",t),e}function kt(e,t){e.styleSheet?e.styleSheet.cssText=t:e.appendChild(document.createTextNode(t))}function zt(e){var t=document.head||document.getElementsByTagName("head")[0];t.appendChild(e)}var At=function(){var e=0,t=null;return{add:function(r){e==0&&(t=Tt())&&(kt(t,r),zt(t)),e++},remove:function(){e--,!e&&t&&(t.parentNode&&t.parentNode.removeChild(t),t=null)}}},Dt=function(){var e=At();return function(t,r){s.useEffect(function(){return e.add(t),function(){e.remove()}},[t&&r])}},Be=function(){var e=Dt(),t=function(r){var n=r.styles,a=r.dynamic;return e(n,a),null};return t},Lt={left:0,top:0,right:0,gap:0},ae=function(e){return parseInt(e||"",10)||0},Ht=function(e){var t=window.getComputedStyle(document.body),r=t[e==="padding"?"paddingLeft":"marginLeft"],n=t[e==="padding"?"paddingTop":"marginTop"],a=t[e==="padding"?"paddingRight":"marginRight"];return[ae(r),ae(n),ae(a)]},Wt=function(e){if(e===void 0&&(e="margin"),typeof window>"u")return Lt;var t=Ht(e),r=document.documentElement.clientWidth,n=window.innerWidth;return{left:t[0],top:t[1],right:t[2],gap:Math.max(0,n-r+t[2]-t[0])}},Vt=Be(),Ft=function(e,t,r,n){var a=e.left,o=e.top,i=e.right,l=e.gap;return r===void 0&&(r="margin"),`
  .`.concat($t,` {
   overflow: hidden `).concat(n,`;
   padding-right: `).concat(l,"px ").concat(n,`;
  }
  body {
    overflow: hidden `).concat(n,`;
    overscroll-behavior: contain;
    `).concat([t&&"position: relative ".concat(n,";"),r==="margin"&&`
    padding-left: `.concat(a,`px;
    padding-top: `).concat(o,`px;
    padding-right: `).concat(i,`px;
    margin-left:0;
    margin-top:0;
    margin-right: `).concat(l,"px ").concat(n,`;
    `),r==="padding"&&"padding-right: ".concat(l,"px ").concat(n,";")].filter(Boolean).join(""),`
  }
  
  .`).concat(H,` {
    right: `).concat(l,"px ").concat(n,`;
  }
  
  .`).concat(W,` {
    margin-right: `).concat(l,"px ").concat(n,`;
  }
  
  .`).concat(H," .").concat(H,` {
    right: 0 `).concat(n,`;
  }
  
  .`).concat(W," .").concat(W,` {
    margin-right: 0 `).concat(n,`;
  }
  
  body {
    `).concat(Et,": ").concat(l,`px;
  }
`)},Xt=function(e){var t=e.noRelative,r=e.noImportant,n=e.gapMode,a=n===void 0?"margin":n,o=s.useMemo(function(){return Wt(a)},[a]);return s.createElement(Vt,{styles:Ft(o,!t,a,r?"":"!important")})},le=!1;if(typeof window<"u")try{var D=Object.defineProperty({},"passive",{get:function(){return le=!0,!0}});window.addEventListener("test",D,D),window.removeEventListener("test",D,D)}catch{le=!1}var I=le?{passive:!1}:!1,Yt=function(e){return e.tagName==="TEXTAREA"},Me=function(e,t){var r=window.getComputedStyle(e);return r[t]!=="hidden"&&!(r.overflowY===r.overflowX&&!Yt(e)&&r[t]==="visible")},Zt=function(e){return Me(e,"overflowY")},Kt=function(e){return Me(e,"overflowX")},fe=function(e,t){var r=t.ownerDocument,n=t;do{typeof ShadowRoot<"u"&&n instanceof ShadowRoot&&(n=n.host);var a=Ie(e,n);if(a){var o=je(e,n),i=o[1],l=o[2];if(i>l)return!0}n=n.parentNode}while(n&&n!==r.body);return!1},Qt=function(e){var t=e.scrollTop,r=e.scrollHeight,n=e.clientHeight;return[t,r,n]},Gt=function(e){var t=e.scrollLeft,r=e.scrollWidth,n=e.clientWidth;return[t,r,n]},Ie=function(e,t){return e==="v"?Zt(t):Kt(t)},je=function(e,t){return e==="v"?Qt(t):Gt(t)},qt=function(e,t){return e==="h"&&t==="rtl"?-1:1},Jt=function(e,t,r,n,a){var o=qt(e,window.getComputedStyle(t).direction),i=o*n,l=r.target,f=t.contains(l),v=!1,p=i>0,y=0,m=0;do{var _=je(e,l),P=_[0],c=_[1],d=_[2],w=c-d-o*P;(P||w)&&Ie(e,l)&&(y+=w,m+=P),l=l.parentNode}while(!f&&l!==document.body||f&&(t.contains(l)||t===l));return(p&&(a&&y===0||!a&&i>y)||!p&&(a&&m===0||!a&&-i>m))&&(v=!0),v},L=function(e){return"changedTouches"in e?[e.changedTouches[0].clientX,e.changedTouches[0].clientY]:[0,0]},ve=function(e){return[e.deltaX,e.deltaY]},pe=function(e){return e&&"current"in e?e.current:e},Ut=function(e,t){return e[0]===t[0]&&e[1]===t[1]},er=function(e){return`
  .block-interactivity-`.concat(e,` {pointer-events: none;}
  .allow-interactivity-`).concat(e,` {pointer-events: all;}
`)},tr=0,j=[];function rr(e){var t=s.useRef([]),r=s.useRef([0,0]),n=s.useRef(),a=s.useState(tr++)[0],o=s.useState(Be)[0],i=s.useRef(e);s.useEffect(function(){i.current=e},[e]),s.useEffect(function(){if(e.inert){document.body.classList.add("block-interactivity-".concat(a));var c=bt([e.lockRef.current],(e.shards||[]).map(pe),!0).filter(Boolean);return c.forEach(function(d){return d.classList.add("allow-interactivity-".concat(a))}),function(){document.body.classList.remove("block-interactivity-".concat(a)),c.forEach(function(d){return d.classList.remove("allow-interactivity-".concat(a))})}}},[e.inert,e.lockRef.current,e.shards]);var l=s.useCallback(function(c,d){if("touches"in c&&c.touches.length===2)return!i.current.allowPinchZoom;var w=L(c),S=r.current,O="deltaX"in c?c.deltaX:S[0]-w[0],b="deltaY"in c?c.deltaY:S[1]-w[1],g,C=c.target,x=Math.abs(O)>Math.abs(b)?"h":"v";if("touches"in c&&x==="h"&&C.type==="range")return!1;var M=fe(x,C);if(!M)return!0;if(M?g=x:(g=x==="v"?"h":"v",M=fe(x,C)),!M)return!1;if(!n.current&&"changedTouches"in c&&(O||b)&&(n.current=g),!g)return!0;var A=n.current||g;return Jt(A,d,c,A==="h"?O:b,!0)},[]),f=s.useCallback(function(c){var d=c;if(!(!j.length||j[j.length-1]!==o)){var w="deltaY"in d?ve(d):L(d),S=t.current.filter(function(g){return g.name===d.type&&g.target===d.target&&Ut(g.delta,w)})[0];if(S&&S.should){d.cancelable&&d.preventDefault();return}if(!S){var O=(i.current.shards||[]).map(pe).filter(Boolean).filter(function(g){return g.contains(d.target)}),b=O.length>0?l(d,O[0]):!i.current.noIsolation;b&&d.cancelable&&d.preventDefault()}}},[]),v=s.useCallback(function(c,d,w,S){var O={name:c,delta:d,target:w,should:S};t.current.push(O),setTimeout(function(){t.current=t.current.filter(function(b){return b!==O})},1)},[]),p=s.useCallback(function(c){r.current=L(c),n.current=void 0},[]),y=s.useCallback(function(c){v(c.type,ve(c),c.target,l(c,e.lockRef.current))},[]),m=s.useCallback(function(c){v(c.type,L(c),c.target,l(c,e.lockRef.current))},[]);s.useEffect(function(){return j.push(o),e.setCallbacks({onScrollCapture:y,onWheelCapture:y,onTouchMoveCapture:m}),document.addEventListener("wheel",f,I),document.addEventListener("touchmove",f,I),document.addEventListener("touchstart",p,I),function(){j=j.filter(function(c){return c!==o}),document.removeEventListener("wheel",f,I),document.removeEventListener("touchmove",f,I),document.removeEventListener("touchstart",p,I)}},[]);var _=e.removeScrollBar,P=e.inert;return s.createElement(s.Fragment,null,P?s.createElement(o,{styles:er(a)}):null,_?s.createElement(Xt,{gapMode:e.gapMode}):null)}const nr=It(Ne,rr);var Te=s.forwardRef(function(e,t){return s.createElement(te,$({},e,{ref:t,sideCar:nr}))});Te.classNames=te.classNames;const ar=Te,[or,T]=Ee("ModalBase component was not found in tree");var lr=N(()=>({close:{marginLeft:"auto",marginRight:0}}));const ir=lr;var sr=Object.defineProperty,F=Object.getOwnPropertySymbols,ke=Object.prototype.hasOwnProperty,ze=Object.prototype.propertyIsEnumerable,me=(e,t,r)=>t in e?sr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,cr=(e,t)=>{for(var r in t||(t={}))ke.call(t,r)&&me(e,r,t[r]);if(F)for(var r of F(t))ze.call(t,r)&&me(e,r,t[r]);return e},ur=(e,t)=>{var r={};for(var n in e)ke.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&F)for(var n of F(e))t.indexOf(n)<0&&ze.call(e,n)&&(r[n]=e[n]);return r};const dr={size:"sm"},fr=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}CloseButton`,dr,e),{className:a}=n,o=ur(n,["className"]),{classes:i,cx:l}=ir(null,r.stylesApi);return u.createElement(pt,cr({className:l(i.close,a),ref:t,onClick:r.onClose},o))});var vr=N(()=>({overlay:{}}));const pr=vr;var mr=Object.defineProperty,hr=Object.defineProperties,gr=Object.getOwnPropertyDescriptors,X=Object.getOwnPropertySymbols,Ae=Object.prototype.hasOwnProperty,De=Object.prototype.propertyIsEnumerable,he=(e,t,r)=>t in e?mr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,k=(e,t)=>{for(var r in t||(t={}))Ae.call(t,r)&&he(e,r,t[r]);if(X)for(var r of X(t))De.call(t,r)&&he(e,r,t[r]);return e},yr=(e,t)=>hr(e,gr(t)),_r=(e,t)=>{var r={};for(var n in e)Ae.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&X)for(var n of X(e))t.indexOf(n)<0&&De.call(e,n)&&(r[n]=e[n]);return r};const wr={},Or=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}Overlay`,wr,e),{onClick:a,transitionProps:o,style:i,className:l}=n,f=_r(n,["onClick","transitionProps","style","className"]),{classes:v,cx:p}=pr(null,r.stylesApi),y=m=>{a==null||a(m),r.closeOnClickOutside&&r.onClose()};return u.createElement(Ce,yr(k(k({mounted:r.opened},r.transitionProps),o),{transition:"fade"}),m=>u.createElement(mt,k({ref:t,onClick:y,fixed:!0,style:k(k({},i),m),className:p(v.overlay,l),zIndex:r.zIndex},f)))});var Pr=N((e,{zIndex:t})=>({inner:{position:"fixed",width:"100%",top:0,bottom:0,maxHeight:"100%",zIndex:t,pointerEvents:"none"},content:{pointerEvents:"all"}}));const Sr=Pr;var br=Object.defineProperty,Y=Object.getOwnPropertySymbols,Le=Object.prototype.hasOwnProperty,He=Object.prototype.propertyIsEnumerable,ge=(e,t,r)=>t in e?br(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,z=(e,t)=>{for(var r in t||(t={}))Le.call(t,r)&&ge(e,r,t[r]);if(Y)for(var r of Y(t))He.call(t,r)&&ge(e,r,t[r]);return e},$r=(e,t)=>{var r={};for(var n in e)Le.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&Y)for(var n of Y(e))t.indexOf(n)<0&&He.call(e,n)&&(r[n]=e[n]);return r};const Er={},Cr=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}Content`,Er,e),{className:a,transitionProps:o,style:i,onKeyDown:l}=n,f=$r(n,["className","transitionProps","style","onKeyDown"]),{classes:v,cx:p}=Sr({zIndex:r.zIndex},r.stylesApi),y=m=>{var _;((_=m.target)==null?void 0:_.getAttribute("data-mantine-stop-propagation"))!=="true"&&m.key==="Escape"&&r.closeOnEscape&&r.onClose(),l==null||l(m)};return u.createElement(Ce,z(z({mounted:r.opened,transition:"pop"},r.transitionProps),o),m=>u.createElement("div",{className:p(v.inner)},u.createElement(ht,{active:r.opened&&r.trapFocus},u.createElement(Pt,z({component:"section",role:"dialog",tabIndex:-1,"aria-modal":!0,"aria-describedby":r.bodyMounted?r.getBodyId():void 0,"aria-labelledby":r.titleMounted?r.getTitleId():void 0,onKeyDown:y,ref:t,className:p(v.content,a),style:z(z({},i),m),shadow:r.shadow},f),f.children))))});var xr=N((e,{padding:t})=>{const r=se({size:t,sizes:e.spacing});return{header:{display:"flex",justifyContent:"space-between",alignItems:"center",padding:r,paddingRight:`calc(${r} - ${R(5)})`,position:"sticky",top:0,backgroundColor:e.colorScheme==="dark"?e.colors.dark[7]:e.white,zIndex:1e3}}});const Rr=xr;var Nr=Object.defineProperty,Z=Object.getOwnPropertySymbols,We=Object.prototype.hasOwnProperty,Ve=Object.prototype.propertyIsEnumerable,ye=(e,t,r)=>t in e?Nr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,Br=(e,t)=>{for(var r in t||(t={}))We.call(t,r)&&ye(e,r,t[r]);if(Z)for(var r of Z(t))Ve.call(t,r)&&ye(e,r,t[r]);return e},Mr=(e,t)=>{var r={};for(var n in e)We.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&Z)for(var n of Z(e))t.indexOf(n)<0&&Ve.call(e,n)&&(r[n]=e[n]);return r};const Ir={},jr=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}Header`,Ir,e),{className:a}=n,o=Mr(n,["className"]),{classes:i,cx:l}=Rr({padding:r.padding},r.stylesApi);return u.createElement(ee,Br({ref:t,className:l(i.header,a)},o))});var Tr=N(e=>({title:{lineHeight:1,padding:0,margin:0,fontWeight:400,fontSize:e.fontSizes.md}}));const kr=Tr;var zr=Object.defineProperty,K=Object.getOwnPropertySymbols,Fe=Object.prototype.hasOwnProperty,Xe=Object.prototype.propertyIsEnumerable,_e=(e,t,r)=>t in e?zr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,Ar=(e,t)=>{for(var r in t||(t={}))Fe.call(t,r)&&_e(e,r,t[r]);if(K)for(var r of K(t))Xe.call(t,r)&&_e(e,r,t[r]);return e},Dr=(e,t)=>{var r={};for(var n in e)Fe.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&K)for(var n of K(e))t.indexOf(n)<0&&Xe.call(e,n)&&(r[n]=e[n]);return r};const Lr={},Hr=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}Title`,Lr,e),{className:a}=n,o=Dr(n,["className"]),{classes:i,cx:l}=kr(null,r.stylesApi);return s.useEffect(()=>(r.setTitleMounted(!0),()=>r.setTitleMounted(!1)),[]),u.createElement(ee,Ar({component:"h2",id:r.getTitleId(),className:l(i.title,a),ref:t},o))});var Wr=N((e,{padding:t})=>({body:{padding:se({size:t,sizes:e.spacing}),"&:not(:only-child)":{paddingTop:0}}}));const Vr=Wr;var Fr=Object.defineProperty,Q=Object.getOwnPropertySymbols,Ye=Object.prototype.hasOwnProperty,Ze=Object.prototype.propertyIsEnumerable,we=(e,t,r)=>t in e?Fr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,Xr=(e,t)=>{for(var r in t||(t={}))Ye.call(t,r)&&we(e,r,t[r]);if(Q)for(var r of Q(t))Ze.call(t,r)&&we(e,r,t[r]);return e},Yr=(e,t)=>{var r={};for(var n in e)Ye.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&Q)for(var n of Q(e))t.indexOf(n)<0&&Ze.call(e,n)&&(r[n]=e[n]);return r};const Zr={},Kr=s.forwardRef((e,t)=>{const r=T(),n=E(`${r.__staticSelector}Body`,Zr,e),{className:a}=n,o=Yr(n,["className"]),{classes:i,cx:l}=Vr({padding:r.padding},r.stylesApi);return s.useEffect(()=>(r.setBodyMounted(!0),()=>r.setBodyMounted(!1)),[]),u.createElement(ee,Xr({id:r.getBodyId(),className:l(i.body,a),ref:t},o))});function Qr({children:e}){return u.createElement(u.Fragment,null,e)}function Gr({opened:e,transitionDuration:t}){const[r,n]=s.useState(e),a=s.useRef(),i=gt()?0:t;return s.useEffect(()=>(e?(n(!0),window.clearTimeout(a.current)):i===0?n(!1):a.current=window.setTimeout(()=>n(!1),i),()=>window.clearTimeout(a.current)),[e,i]),r}var qr=N(()=>({root:{}}));const Jr=qr;var Ur=Object.defineProperty,en=Object.defineProperties,tn=Object.getOwnPropertyDescriptors,G=Object.getOwnPropertySymbols,Ke=Object.prototype.hasOwnProperty,Qe=Object.prototype.propertyIsEnumerable,Oe=(e,t,r)=>t in e?Ur(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,oe=(e,t)=>{for(var r in t||(t={}))Ke.call(t,r)&&Oe(e,r,t[r]);if(G)for(var r of G(t))Qe.call(t,r)&&Oe(e,r,t[r]);return e},Pe=(e,t)=>en(e,tn(t)),rn=(e,t)=>{var r={};for(var n in e)Ke.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&G)for(var n of G(e))t.indexOf(n)<0&&Qe.call(e,n)&&(r[n]=e[n]);return r};const ce={closeOnClickOutside:!0,withinPortal:!0,lockScroll:!0,trapFocus:!0,returnFocus:!0,closeOnEscape:!0,keepMounted:!1,zIndex:yt("modal"),padding:"md",size:"md",shadow:"xl"};function h(e){const t=E("ModalBase",ce,e),{opened:r,onClose:n,children:a,closeOnClickOutside:o,__staticSelector:i,transitionProps:l,withinPortal:f,portalProps:v,keepMounted:p,target:y,zIndex:m,lockScroll:_,trapFocus:P,closeOnEscape:c,returnFocus:d,padding:w,shadow:S,id:O,size:b,variant:g,classNames:C,unstyled:x,styles:M,className:A}=t,ot=rn(t,["opened","onClose","children","closeOnClickOutside","__staticSelector","transitionProps","withinPortal","portalProps","keepMounted","target","zIndex","lockScroll","trapFocus","closeOnEscape","returnFocus","padding","shadow","id","size","variant","classNames","unstyled","styles","className"]),{classes:lt,cx:it}=Jr(null,{name:i,classNames:C,styles:M,unstyled:x,variant:g,size:b}),re=_t(O),[st,ct]=s.useState(!1),[ut,dt]=s.useState(!1),ue=typeof(l==null?void 0:l.duration)=="number"?l==null?void 0:l.duration:200,ft=Gr({opened:r,transitionDuration:ue});return St("keydown",vt=>{!P&&vt.key==="Escape"&&c&&n()}),wt({opened:r,shouldReturnFocus:P&&d}),u.createElement(Ot,Pe(oe({},v),{withinPortal:f,target:y}),u.createElement(or,{value:{__staticSelector:i,opened:r,onClose:n,closeOnClickOutside:o,transitionProps:Pe(oe({},l),{duration:ue,keepMounted:p}),zIndex:m,padding:w,id:re,getTitleId:()=>`${re}-title`,getBodyId:()=>`${re}-body`,titleMounted:st,bodyMounted:ut,setTitleMounted:ct,setBodyMounted:dt,trapFocus:P,closeOnEscape:c,shadow:S,stylesApi:{name:i,size:b,variant:g,classNames:C,styles:M,unstyled:x}}},u.createElement(ar,{enabled:ft&&_},u.createElement(ee,oe({className:it(lt.root,A)},ot),a))))}h.CloseButton=fr;h.Overlay=Or;h.Content=Cr;h.Header=jr;h.Title=Hr;h.Body=Kr;h.NativeScrollArea=Qr;const[nn,an]=Ee("Modal component was not found in tree"),on={xs:R(320),sm:R(380),md:R(440),lg:R(620),xl:R(780)};var ln=N((e,{yOffset:t,xOffset:r,centered:n,fullScreen:a},{size:o})=>({content:{flex:a?"0 0 100%":`0 0 ${se({size:o,sizes:on})}`,maxWidth:"100%",maxHeight:a?void 0:`calc(100dvh - (${R(t)} * 2))`,height:a?"100vh":void 0,borderRadius:a?0:void 0,overflowY:"auto"},inner:{paddingTop:a?0:t,paddingBottom:a?0:t,paddingLeft:a?0:r,paddingRight:a?0:r,display:"flex",justifyContent:"center",alignItems:n?"center":"flex-start"}}));const sn=ln;var cn=Object.defineProperty,un=Object.defineProperties,dn=Object.getOwnPropertyDescriptors,q=Object.getOwnPropertySymbols,Ge=Object.prototype.hasOwnProperty,qe=Object.prototype.propertyIsEnumerable,Se=(e,t,r)=>t in e?cn(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,ie=(e,t)=>{for(var r in t||(t={}))Ge.call(t,r)&&Se(e,r,t[r]);if(q)for(var r of q(t))qe.call(t,r)&&Se(e,r,t[r]);return e},Je=(e,t)=>un(e,dn(t)),fn=(e,t)=>{var r={};for(var n in e)Ge.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&q)for(var n of q(e))t.indexOf(n)<0&&qe.call(e,n)&&(r[n]=e[n]);return r};const vn=Je(ie({},ce),{yOffset:"5dvh",xOffset:"5vw"});function Ue(e){const t=E("ModalRoot",vn,e),{classNames:r,variant:n,size:a,yOffset:o,xOffset:i,scrollAreaComponent:l,radius:f,centered:v,fullScreen:p}=t,y=fn(t,["classNames","variant","size","yOffset","xOffset","scrollAreaComponent","radius","centered","fullScreen"]),{classes:m,cx:_}=sn({yOffset:o,xOffset:i,centered:v,fullScreen:p},{name:"Modal",variant:n,size:a});return u.createElement(nn,{value:{yOffset:o,scrollAreaComponent:l,radius:f}},u.createElement(h,ie({__staticSelector:"Modal",size:a,variant:n,classNames:Je(ie({},r),{content:_(m.content,r==null?void 0:r.content),inner:_(m.inner,r==null?void 0:r.inner)})},y)))}var pn=Object.defineProperty,J=Object.getOwnPropertySymbols,et=Object.prototype.hasOwnProperty,tt=Object.prototype.propertyIsEnumerable,be=(e,t,r)=>t in e?pn(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,mn=(e,t)=>{for(var r in t||(t={}))et.call(t,r)&&be(e,r,t[r]);if(J)for(var r of J(t))tt.call(t,r)&&be(e,r,t[r]);return e},hn=(e,t)=>{var r={};for(var n in e)et.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&J)for(var n of J(e))t.indexOf(n)<0&&tt.call(e,n)&&(r[n]=e[n]);return r};const gn={shadow:"xl"},rt=s.forwardRef((e,t)=>{const r=E("ModalContent",gn,e),{children:n,scrollAreaComponent:a}=r,o=hn(r,["children","scrollAreaComponent"]),i=an(),l=a||i.scrollAreaComponent||h.NativeScrollArea;return u.createElement(h.Content,mn({ref:t,radius:i.radius},o),u.createElement(l,{style:{maxHeight:`calc(100dvh - (${R(i.yOffset)} * 2))`}},n))});var yn=Object.defineProperty,_n=Object.defineProperties,wn=Object.getOwnPropertyDescriptors,U=Object.getOwnPropertySymbols,nt=Object.prototype.hasOwnProperty,at=Object.prototype.propertyIsEnumerable,$e=(e,t,r)=>t in e?yn(e,t,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[t]=r,V=(e,t)=>{for(var r in t||(t={}))nt.call(t,r)&&$e(e,r,t[r]);if(U)for(var r of U(t))at.call(t,r)&&$e(e,r,t[r]);return e},On=(e,t)=>_n(e,wn(t)),Pn=(e,t)=>{var r={};for(var n in e)nt.call(e,n)&&t.indexOf(n)<0&&(r[n]=e[n]);if(e!=null&&U)for(var n of U(e))t.indexOf(n)<0&&at.call(e,n)&&(r[n]=e[n]);return r};const Sn=On(V({},ce),{transitionProps:{duration:200,transition:"pop"},withOverlay:!0,withCloseButton:!0});function B(e){const t=E("Modal",Sn,e),{title:r,withOverlay:n,overlayProps:a,withCloseButton:o,closeButtonProps:i,children:l}=t,f=Pn(t,["title","withOverlay","overlayProps","withCloseButton","closeButtonProps","children"]),v=!!r||o;return u.createElement(Ue,V({},f),n&&u.createElement(h.Overlay,V({},a)),u.createElement(rt,null,v&&u.createElement(h.Header,null,r&&u.createElement(h.Title,null,r),o&&u.createElement(h.CloseButton,V({},i))),u.createElement(h.Body,null,l)))}B.Root=Ue;B.CloseButton=h.CloseButton;B.Overlay=h.Overlay;B.Content=rt;B.Header=h.Header;B.Title=h.Title;B.Body=h.Body;B.NativeScrollArea=h.NativeScrollArea;export{B as M};