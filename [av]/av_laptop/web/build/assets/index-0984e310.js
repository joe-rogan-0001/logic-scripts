import{r as I,m as C,n as qe,o as T,R as E,e as Ke,p as ba,a as ga,q as ya,t as ha,v as wa,P as g}from"./index-30f42a89.js";import{c as be}from"./clamp-23377890.js";function ka(e,t,n="ltr"){const a=I.useRef(),r=I.useRef(!1),i=I.useRef(!1),o=I.useRef(0),[s,l]=I.useState(!1);return I.useEffect(()=>{r.current=!0},[]),I.useEffect(()=>{const f=({x:b,y:O})=>{cancelAnimationFrame(o.current),o.current=requestAnimationFrame(()=>{if(r.current&&a.current){a.current.style.userSelect="none";const k=a.current.getBoundingClientRect();if(k.width&&k.height){const S=be((b-k.left)/k.width,0,1);e({x:n==="ltr"?S:1-S,y:be((O-k.top)/k.height,0,1)})}}})},c=()=>{document.addEventListener("mousemove",y),document.addEventListener("mouseup",p),document.addEventListener("touchmove",x),document.addEventListener("touchend",p)},u=()=>{document.removeEventListener("mousemove",y),document.removeEventListener("mouseup",p),document.removeEventListener("touchmove",x),document.removeEventListener("touchend",p)},d=()=>{!i.current&&r.current&&(i.current=!0,typeof(t==null?void 0:t.onScrubStart)=="function"&&t.onScrubStart(),l(!0),c())},p=()=>{i.current&&r.current&&(i.current=!1,l(!1),u(),setTimeout(()=>{typeof(t==null?void 0:t.onScrubEnd)=="function"&&t.onScrubEnd()},0))},h=b=>{d(),b.preventDefault(),y(b)},y=b=>f({x:b.clientX,y:b.clientY}),w=b=>{b.cancelable&&b.preventDefault(),d(),x(b)},x=b=>{b.cancelable&&b.preventDefault(),f({x:b.changedTouches[0].clientX,y:b.changedTouches[0].clientY})};return a.current.addEventListener("mousedown",h),a.current.addEventListener("touchstart",w,{passive:!1}),()=>{a.current&&(a.current.removeEventListener("mousedown",h),a.current.removeEventListener("touchstart",w))}},[n,e]),{ref:a,active:s}}function On({value:e,min:t,max:n}){const a=(e-t)/(n-t)*100;return Math.min(Math.max(a,0),100)}function xa({value:e,containerWidth:t,min:n,max:a,step:r,precision:i}){const s=(t?Math.min(Math.max(e,0),t)/t:e)*(a-n),l=(s!==0?Math.round(s/r)*r:0)+n,f=Math.max(l,n);return i!==void 0?Number(f.toFixed(i)):f}var Oa=Object.defineProperty,Sa=Object.defineProperties,Aa=Object.getOwnPropertyDescriptors,Yt=Object.getOwnPropertySymbols,Pa=Object.prototype.hasOwnProperty,_a=Object.prototype.propertyIsEnumerable,Vt=(e,t,n)=>t in e?Oa(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n,Ea=(e,t)=>{for(var n in t||(t={}))Pa.call(t,n)&&Vt(e,n,t[n]);if(Yt)for(var n of Yt(t))_a.call(t,n)&&Vt(e,n,t[n]);return e},Ca=(e,t)=>Sa(e,Aa(t));const M={xs:C(4),sm:C(6),md:C(8),lg:C(10),xl:C(12)};var Na=qe(e=>({root:Ca(Ea({},e.fn.fontStyles()),{WebkitTapHighlightColor:"transparent",outline:0,display:"flex",flexDirection:"column",alignItems:"center",touchAction:"none",position:"relative"})}));const Ia=Na;var Ta=Object.defineProperty,Ma=Object.defineProperties,La=Object.getOwnPropertyDescriptors,Ut=Object.getOwnPropertySymbols,$a=Object.prototype.hasOwnProperty,Ra=Object.prototype.propertyIsEnumerable,Ht=(e,t,n)=>t in e?Ta(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n,Fa=(e,t)=>{for(var n in t||(t={}))$a.call(t,n)&&Ht(e,n,t[n]);if(Ut)for(var n of Ut(t))Ra.call(t,n)&&Ht(e,n,t[n]);return e},ja=(e,t)=>Ma(e,La(t)),Da=qe((e,{color:t,disabled:n,thumbSize:a},{size:r})=>({label:{position:"absolute",top:C(-36),backgroundColor:e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[9],fontSize:e.fontSizes.xs,color:e.white,padding:`calc(${e.spacing.xs} / 2)`,borderRadius:e.radius.sm,whiteSpace:"nowrap",pointerEvents:"none",userSelect:"none",touchAction:"none"},thumb:ja(Fa({},e.fn.focusStyles()),{boxSizing:"border-box",position:"absolute",display:n?"none":"flex",height:a?C(a):`calc(${T({sizes:M,size:r})} * 2)`,width:a?C(a):`calc(${T({sizes:M,size:r})} * 2)`,backgroundColor:e.colorScheme==="dark"?e.fn.themeColor(t,e.fn.primaryShade()):e.white,border:`${C(4)} solid ${e.colorScheme==="dark"?e.white:e.fn.themeColor(t,e.fn.primaryShade())}`,color:e.colorScheme==="dark"?e.white:e.fn.themeColor(t,e.fn.primaryShade()),transform:"translate(-50%, -50%)",top:"50%",cursor:"pointer",borderRadius:1e3,alignItems:"center",justifyContent:"center",transitionDuration:"100ms",transitionProperty:"box-shadow, transform",transitionTimingFunction:e.transitionTimingFunction,zIndex:3,userSelect:"none",touchAction:"none"}),dragging:{transform:"translate(-50%, -50%) scale(1.05)",boxShadow:e.shadows.sm}}));const za=Da,Sn=I.forwardRef(({max:e,min:t,value:n,position:a,label:r,dragging:i,onMouseDown:o,onKeyDownCapture:s,color:l,classNames:f,styles:c,size:u,labelTransition:d,labelTransitionDuration:p,labelTransitionTimingFunction:h,labelAlwaysOn:y,thumbLabel:w,onFocus:x,onBlur:b,showLabelOnHover:O,isHovered:k,children:S=null,disabled:j,unstyled:D,thumbSize:H,variant:R},Y)=>{const{classes:ne,cx:_e,theme:Ee}=za({color:l,disabled:j,thumbSize:H},{name:"Slider",classNames:f,styles:c,unstyled:D,variant:R,size:u}),[nt,le]=I.useState(!1),at=y||i||nt||O&&k;return E.createElement(Ke,{tabIndex:0,role:"slider","aria-label":w,"aria-valuemax":e,"aria-valuemin":t,"aria-valuenow":n,ref:Y,className:_e(ne.thumb,{[ne.dragging]:i}),onFocus:()=>{le(!0),typeof x=="function"&&x()},onBlur:()=>{le(!1),typeof b=="function"&&b()},onTouchStart:o,onMouseDown:o,onKeyDownCapture:s,onClick:V=>V.stopPropagation(),style:{[Ee.dir==="rtl"?"right":"left"]:`${a}%`}},S,E.createElement(ba,{mounted:r!=null&&at,duration:p,transition:d,timingFunction:h||Ee.transitionTimingFunction},V=>E.createElement("div",{style:V,className:ne.label},r)))});Sn.displayName="@mantine/core/SliderThumb";function Ya({mark:e,offset:t,value:n,inverted:a=!1}){return a?typeof t=="number"&&e.value<=t||e.value>=n:typeof t=="number"?e.value>=t&&e.value<=n:e.value<=n}var Va=qe((e,{color:t,disabled:n,thumbSize:a},{size:r})=>({marksContainer:{position:"absolute",right:a?C(a/2):T({sizes:M,size:r}),left:a?C(a/2):T({sizes:M,size:r}),"&:has(~ input:disabled)":{"& .mantine-Slider-markFilled":{border:`${C(2)} solid ${e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2]}`,borderColor:e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]}}},markWrapper:{position:"absolute",top:`calc(${C(T({sizes:M,size:r}))} / 2)`,zIndex:2,height:0},mark:{boxSizing:"border-box",border:`${C(2)} solid ${e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2]}`,height:T({sizes:M,size:r}),width:T({sizes:M,size:r}),borderRadius:1e3,transform:`translateX(calc(-${T({sizes:M,size:r})} / 2))`,backgroundColor:e.white,pointerEvents:"none"},markFilled:{borderColor:n?e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]:e.fn.variant({variant:"filled",color:t}).background},markLabel:{transform:`translate(-50%, calc(${e.spacing.xs} / 2))`,fontSize:e.fontSizes.sm,color:e.colorScheme==="dark"?e.colors.dark[2]:e.colors.gray[6],whiteSpace:"nowrap",cursor:"pointer",userSelect:"none"}}));const Ua=Va;function An({marks:e,color:t,size:n,thumbSize:a,min:r,max:i,value:o,classNames:s,styles:l,offset:f,onChange:c,disabled:u,unstyled:d,inverted:p,variant:h}){const{classes:y,cx:w}=Ua({color:t,disabled:u,thumbSize:a},{name:"Slider",classNames:s,styles:l,unstyled:d,variant:h,size:n}),x=e.map((b,O)=>E.createElement(Ke,{className:y.markWrapper,sx:{left:`${On({value:b.value,min:r,max:i})}%`},key:O},E.createElement("div",{className:w(y.mark,{[y.markFilled]:Ya({mark:b,value:o,offset:f,inverted:p})})}),b.label&&E.createElement("div",{className:y.markLabel,onMouseDown:k=>{k.stopPropagation(),!u&&c(b.value)},onTouchStart:k=>{k.stopPropagation(),!u&&c(b.value)}},b.label)));return E.createElement("div",{className:y.marksContainer},x)}An.displayName="@mantine/core/SliderMarks";var Ha=qe((e,{radius:t,color:n,disabled:a,inverted:r,thumbSize:i},{size:o})=>({trackContainer:{display:"flex",alignItems:"center",width:"100%",height:`calc(${T({sizes:M,size:o})} * 2)`,cursor:"pointer","&:has(~ input:disabled)":{"&":{pointerEvents:"none"},"& .mantine-Slider-thumb":{display:"none"},"& .mantine-Slider-track::before":{content:'""',backgroundColor:r?e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]:e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2]},"& .mantine-Slider-bar":{backgroundColor:r?e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2]:e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]}}},track:{position:"relative",height:T({sizes:M,size:o}),width:"100%",marginRight:i?C(i/2):T({size:o,sizes:M}),marginLeft:i?C(i/2):T({size:o,sizes:M}),"&::before":{content:'""',position:"absolute",top:0,bottom:0,borderRadius:e.fn.radius(t),right:`calc(${i?C(i/2):T({size:o,sizes:M})} * -1)`,left:`calc(${i?C(i/2):T({size:o,sizes:M})} * -1)`,backgroundColor:r?a?e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]:e.fn.variant({variant:"filled",color:n}).background:e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2],zIndex:0}},bar:{position:"absolute",zIndex:1,top:0,bottom:0,backgroundColor:r?e.colorScheme==="dark"?e.colors.dark[4]:e.colors.gray[2]:a?e.colorScheme==="dark"?e.colors.dark[3]:e.colors.gray[4]:e.fn.variant({variant:"filled",color:n}).background,borderRadius:e.fn.radius(t)}}));const Wa=Ha;var Xa=Object.defineProperty,Ga=Object.defineProperties,Ba=Object.getOwnPropertyDescriptors,Ve=Object.getOwnPropertySymbols,Pn=Object.prototype.hasOwnProperty,_n=Object.prototype.propertyIsEnumerable,Wt=(e,t,n)=>t in e?Xa(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n,Xt=(e,t)=>{for(var n in t||(t={}))Pn.call(t,n)&&Wt(e,n,t[n]);if(Ve)for(var n of Ve(t))_n.call(t,n)&&Wt(e,n,t[n]);return e},qa=(e,t)=>Ga(e,Ba(t)),Ka=(e,t)=>{var n={};for(var a in e)Pn.call(e,a)&&t.indexOf(a)<0&&(n[a]=e[a]);if(e!=null&&Ve)for(var a of Ve(e))t.indexOf(a)<0&&_n.call(e,a)&&(n[a]=e[a]);return n};function En(e){var t=e,{filled:n,size:a,thumbSize:r,color:i,classNames:o,styles:s,radius:l,children:f,offset:c,disabled:u,marksOffset:d,unstyled:p,inverted:h,variant:y,containerProps:w}=t,x=Ka(t,["filled","size","thumbSize","color","classNames","styles","radius","children","offset","disabled","marksOffset","unstyled","inverted","variant","containerProps"]);const{classes:b}=Wa({color:i,radius:l,disabled:u,inverted:h,thumbSize:r},{name:"Slider",classNames:o,styles:s,unstyled:p,variant:y,size:a});return E.createElement(E.Fragment,null,E.createElement("div",Xt({className:b.trackContainer},w),E.createElement("div",{className:b.track},E.createElement(Ke,{className:b.bar,sx:{left:`calc(${c}% - ${r?C(r/2):T({size:a,sizes:M})})`,width:`calc(${n}% + 2 * ${r?C(r/2):T({size:a,sizes:M})})`}}),f)),E.createElement(An,qa(Xt({},x),{size:a,thumbSize:r,color:i,offset:d,classNames:o,styles:s,disabled:u,unstyled:p,inverted:h,variant:y})))}En.displayName="@mantine/core/SliderTrack";var Qa=Object.defineProperty,Ja=Object.defineProperties,Za=Object.getOwnPropertyDescriptors,Ue=Object.getOwnPropertySymbols,Cn=Object.prototype.hasOwnProperty,Nn=Object.prototype.propertyIsEnumerable,Gt=(e,t,n)=>t in e?Qa(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n,er=(e,t)=>{for(var n in t||(t={}))Cn.call(t,n)&&Gt(e,n,t[n]);if(Ue)for(var n of Ue(t))Nn.call(t,n)&&Gt(e,n,t[n]);return e},tr=(e,t)=>Ja(e,Za(t)),nr=(e,t)=>{var n={};for(var a in e)Cn.call(e,a)&&t.indexOf(a)<0&&(n[a]=e[a]);if(e!=null&&Ue)for(var a of Ue(e))t.indexOf(a)<0&&Nn.call(e,a)&&(n[a]=e[a]);return n};const In=I.forwardRef((e,t)=>{var n=e,{className:a,size:r,classNames:i,styles:o,disabled:s,unstyled:l,variant:f}=n,c=nr(n,["className","size","classNames","styles","disabled","unstyled","variant"]);const{classes:u,cx:d}=Ia(null,{name:"Slider",classNames:i,styles:o,unstyled:l,variant:f,size:r});return E.createElement(Ke,tr(er({},c),{tabIndex:-1,className:d(u.root,a),ref:t}))});In.displayName="@mantine/core/SliderRoot";function Ne(e,t){return parseFloat(e.toFixed(t))}function ar(e){if(!e)return 0;const t=e.toString().split(".");return t.length>1?t[1].length:0}var rr=Object.defineProperty,ir=Object.defineProperties,or=Object.getOwnPropertyDescriptors,He=Object.getOwnPropertySymbols,Tn=Object.prototype.hasOwnProperty,Mn=Object.prototype.propertyIsEnumerable,Bt=(e,t,n)=>t in e?rr(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n,sr=(e,t)=>{for(var n in t||(t={}))Tn.call(t,n)&&Bt(e,n,t[n]);if(He)for(var n of He(t))Mn.call(t,n)&&Bt(e,n,t[n]);return e},lr=(e,t)=>ir(e,or(t)),fr=(e,t)=>{var n={};for(var a in e)Tn.call(e,a)&&t.indexOf(a)<0&&(n[a]=e[a]);if(e!=null&&He)for(var a of He(e))t.indexOf(a)<0&&Mn.call(e,a)&&(n[a]=e[a]);return n};const cr={size:"md",radius:"xl",min:0,max:100,step:1,marks:[],label:e=>e,labelTransition:"skew-down",labelTransitionDuration:0,labelAlwaysOn:!1,thumbLabel:"",showLabelOnHover:!0,disabled:!1,scale:e=>e},ur=I.forwardRef((e,t)=>{const n=ga("Slider",cr,e),{classNames:a,styles:r,color:i,value:o,onChange:s,onChangeEnd:l,size:f,radius:c,min:u,max:d,step:p,precision:h,defaultValue:y,name:w,marks:x,label:b,labelTransition:O,labelTransitionDuration:k,labelTransitionTimingFunction:S,labelAlwaysOn:j,thumbLabel:D,showLabelOnHover:H,thumbChildren:R,disabled:Y,unstyled:ne,thumbSize:_e,scale:Ee,inverted:nt,variant:le}=n,at=fr(n,["classNames","styles","color","value","onChange","onChangeEnd","size","radius","min","max","step","precision","defaultValue","name","marks","label","labelTransition","labelTransitionDuration","labelTransitionTimingFunction","labelAlwaysOn","thumbLabel","showLabelOnHover","thumbChildren","disabled","unstyled","thumbSize","scale","inverted","variant"]),V=h??ar(p),rt=ya(),[ca,Ft]=I.useState(!1),[W,X]=ha({value:typeof o=="number"?be(o,u,d):o,defaultValue:typeof y=="number"?be(y,u,d):y,finalValue:be(0,u,d),onChange:s}),jt=I.useRef(W),Dt=I.useRef(),ae=I.useRef(),zt=On({value:W,min:u,max:d}),Ce=Ee(W),ua=typeof b=="function"?b(Ce):b,ma=I.useCallback(({x:F})=>{if(!Y){const L=xa({value:F,min:u,max:d,step:p,precision:V});X(L),jt.current=L}},[Y,u,d,p,V,X]),{ref:da,active:va}=ka(ma,{onScrubEnd:()=>l==null?void 0:l(jt.current)},rt.dir),pa=F=>{if(!Y)switch(F.key){case"ArrowUp":{F.preventDefault(),ae.current.focus();const L=Ne(Math.min(Math.max(W+p,u),d),V);l==null||l(L),X(L);break}case"ArrowRight":{F.preventDefault(),ae.current.focus();const L=Ne(Math.min(Math.max(rt.dir==="rtl"?W-p:W+p,u),d),V);l==null||l(L),X(L);break}case"ArrowDown":{F.preventDefault(),ae.current.focus();const L=Ne(Math.min(Math.max(W-p,u),d),V);l==null||l(L),X(L);break}case"ArrowLeft":{F.preventDefault(),ae.current.focus();const L=Ne(Math.min(Math.max(rt.dir==="rtl"?W+p:W-p,u),d),V);l==null||l(L),X(L);break}case"Home":{F.preventDefault(),ae.current.focus(),l==null||l(u),X(u);break}case"End":{F.preventDefault(),ae.current.focus(),l==null||l(d),X(d);break}}};return E.createElement(In,lr(sr({},at),{ref:wa(t,Dt),onKeyDownCapture:pa,onMouseDownCapture:()=>{var F;return(F=Dt.current)==null?void 0:F.focus()},size:f,classNames:a,styles:r,disabled:Y,unstyled:ne,variant:le}),E.createElement(En,{inverted:nt,offset:0,filled:zt,marks:x,size:f,thumbSize:_e,radius:c,color:i,min:u,max:d,value:Ce,onChange:X,classNames:a,styles:r,disabled:Y,unstyled:ne,variant:le,containerProps:{ref:da,onMouseEnter:H?()=>Ft(!0):void 0,onMouseLeave:H?()=>Ft(!1):void 0}},E.createElement(Sn,{max:d,min:u,value:Ce,position:zt,dragging:va,color:i,size:f,label:ua,ref:ae,labelTransition:O,labelTransitionDuration:k,labelTransitionTimingFunction:S,labelAlwaysOn:j,classNames:a,styles:r,thumbLabel:D,showLabelOnHover:H,isHovered:ca,disabled:Y,unstyled:ne,thumbSize:_e,variant:le},R)),E.createElement("input",{type:"hidden",name:w,value:Ce}))});ur.displayName="@mantine/core/Slider";function qt(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter(function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable})),n.push.apply(n,a)}return n}function m(e){for(var t=1;t<arguments.length;t++){var n=arguments[t]!=null?arguments[t]:{};t%2?qt(Object(n),!0).forEach(function(a){N(e,a,n[a])}):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):qt(Object(n)).forEach(function(a){Object.defineProperty(e,a,Object.getOwnPropertyDescriptor(n,a))})}return e}function We(e){"@babel/helpers - typeof";return We=typeof Symbol=="function"&&typeof Symbol.iterator=="symbol"?function(t){return typeof t}:function(t){return t&&typeof Symbol=="function"&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t},We(e)}function mr(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function Kt(e,t){for(var n=0;n<t.length;n++){var a=t[n];a.enumerable=a.enumerable||!1,a.configurable=!0,"value"in a&&(a.writable=!0),Object.defineProperty(e,a.key,a)}}function dr(e,t,n){return t&&Kt(e.prototype,t),n&&Kt(e,n),Object.defineProperty(e,"prototype",{writable:!1}),e}function N(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function St(e,t){return pr(e)||gr(e,t)||Ln(e,t)||hr()}function Se(e){return vr(e)||br(e)||Ln(e)||yr()}function vr(e){if(Array.isArray(e))return ct(e)}function pr(e){if(Array.isArray(e))return e}function br(e){if(typeof Symbol<"u"&&e[Symbol.iterator]!=null||e["@@iterator"]!=null)return Array.from(e)}function gr(e,t){var n=e==null?null:typeof Symbol<"u"&&e[Symbol.iterator]||e["@@iterator"];if(n!=null){var a=[],r=!0,i=!1,o,s;try{for(n=n.call(e);!(r=(o=n.next()).done)&&(a.push(o.value),!(t&&a.length===t));r=!0);}catch(l){i=!0,s=l}finally{try{!r&&n.return!=null&&n.return()}finally{if(i)throw s}}return a}}function Ln(e,t){if(e){if(typeof e=="string")return ct(e,t);var n=Object.prototype.toString.call(e).slice(8,-1);if(n==="Object"&&e.constructor&&(n=e.constructor.name),n==="Map"||n==="Set")return Array.from(e);if(n==="Arguments"||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return ct(e,t)}}function ct(e,t){(t==null||t>e.length)&&(t=e.length);for(var n=0,a=new Array(t);n<t;n++)a[n]=e[n];return a}function yr(){throw new TypeError(`Invalid attempt to spread non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}function hr(){throw new TypeError(`Invalid attempt to destructure non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}var Qt=function(){},At={},$n={},Rn=null,Fn={mark:Qt,measure:Qt};try{typeof window<"u"&&(At=window),typeof document<"u"&&($n=document),typeof MutationObserver<"u"&&(Rn=MutationObserver),typeof performance<"u"&&(Fn=performance)}catch{}var wr=At.navigator||{},Jt=wr.userAgent,Zt=Jt===void 0?"":Jt,Z=At,P=$n,en=Rn,Ie=Fn;Z.document;var K=!!P.documentElement&&!!P.head&&typeof P.addEventListener=="function"&&typeof P.createElement=="function",jn=~Zt.indexOf("MSIE")||~Zt.indexOf("Trident/"),Te,Me,Le,$e,Re,G="___FONT_AWESOME___",ut=16,Dn="fa",zn="svg-inline--fa",oe="data-fa-i2svg",mt="data-fa-pseudo-element",kr="data-fa-pseudo-element-pending",Pt="data-prefix",_t="data-icon",tn="fontawesome-i2svg",xr="async",Or=["HTML","HEAD","STYLE","SCRIPT"],Yn=function(){try{return!0}catch{return!1}}(),A="classic",_="sharp",Et=[A,_];function Ae(e){return new Proxy(e,{get:function(n,a){return a in n?n[a]:n[A]}})}var he=Ae((Te={},N(Te,A,{fa:"solid",fas:"solid","fa-solid":"solid",far:"regular","fa-regular":"regular",fal:"light","fa-light":"light",fat:"thin","fa-thin":"thin",fad:"duotone","fa-duotone":"duotone",fab:"brands","fa-brands":"brands",fak:"kit","fa-kit":"kit"}),N(Te,_,{fa:"solid",fass:"solid","fa-solid":"solid",fasr:"regular","fa-regular":"regular",fasl:"light","fa-light":"light"}),Te)),we=Ae((Me={},N(Me,A,{solid:"fas",regular:"far",light:"fal",thin:"fat",duotone:"fad",brands:"fab",kit:"fak"}),N(Me,_,{solid:"fass",regular:"fasr",light:"fasl"}),Me)),ke=Ae((Le={},N(Le,A,{fab:"fa-brands",fad:"fa-duotone",fak:"fa-kit",fal:"fa-light",far:"fa-regular",fas:"fa-solid",fat:"fa-thin"}),N(Le,_,{fass:"fa-solid",fasr:"fa-regular",fasl:"fa-light"}),Le)),Sr=Ae(($e={},N($e,A,{"fa-brands":"fab","fa-duotone":"fad","fa-kit":"fak","fa-light":"fal","fa-regular":"far","fa-solid":"fas","fa-thin":"fat"}),N($e,_,{"fa-solid":"fass","fa-regular":"fasr","fa-light":"fasl"}),$e)),Ar=/fa(s|r|l|t|d|b|k|ss|sr|sl)?[\-\ ]/,Vn="fa-layers-text",Pr=/Font ?Awesome ?([56 ]*)(Solid|Regular|Light|Thin|Duotone|Brands|Free|Pro|Sharp|Kit)?.*/i,_r=Ae((Re={},N(Re,A,{900:"fas",400:"far",normal:"far",300:"fal",100:"fat"}),N(Re,_,{900:"fass",400:"fasr",300:"fasl"}),Re)),Un=[1,2,3,4,5,6,7,8,9,10],Er=Un.concat([11,12,13,14,15,16,17,18,19,20]),Cr=["class","data-prefix","data-icon","data-fa-transform","data-fa-mask"],re={GROUP:"duotone-group",SWAP_OPACITY:"swap-opacity",PRIMARY:"primary",SECONDARY:"secondary"},xe=new Set;Object.keys(we[A]).map(xe.add.bind(xe));Object.keys(we[_]).map(xe.add.bind(xe));var Nr=[].concat(Et,Se(xe),["2xs","xs","sm","lg","xl","2xl","beat","border","fade","beat-fade","bounce","flip-both","flip-horizontal","flip-vertical","flip","fw","inverse","layers-counter","layers-text","layers","li","pull-left","pull-right","pulse","rotate-180","rotate-270","rotate-90","rotate-by","shake","spin-pulse","spin-reverse","spin","stack-1x","stack-2x","stack","ul",re.GROUP,re.SWAP_OPACITY,re.PRIMARY,re.SECONDARY]).concat(Un.map(function(e){return"".concat(e,"x")})).concat(Er.map(function(e){return"w-".concat(e)})),ge=Z.FontAwesomeConfig||{};function Ir(e){var t=P.querySelector("script["+e+"]");if(t)return t.getAttribute(e)}function Tr(e){return e===""?!0:e==="false"?!1:e==="true"?!0:e}if(P&&typeof P.querySelector=="function"){var Mr=[["data-family-prefix","familyPrefix"],["data-css-prefix","cssPrefix"],["data-family-default","familyDefault"],["data-style-default","styleDefault"],["data-replacement-class","replacementClass"],["data-auto-replace-svg","autoReplaceSvg"],["data-auto-add-css","autoAddCss"],["data-auto-a11y","autoA11y"],["data-search-pseudo-elements","searchPseudoElements"],["data-observe-mutations","observeMutations"],["data-mutate-approach","mutateApproach"],["data-keep-original-source","keepOriginalSource"],["data-measure-performance","measurePerformance"],["data-show-missing-icons","showMissingIcons"]];Mr.forEach(function(e){var t=St(e,2),n=t[0],a=t[1],r=Tr(Ir(n));r!=null&&(ge[a]=r)})}var Hn={styleDefault:"solid",familyDefault:"classic",cssPrefix:Dn,replacementClass:zn,autoReplaceSvg:!0,autoAddCss:!0,autoA11y:!0,searchPseudoElements:!1,observeMutations:!0,mutateApproach:"async",keepOriginalSource:!0,measurePerformance:!1,showMissingIcons:!0};ge.familyPrefix&&(ge.cssPrefix=ge.familyPrefix);var de=m(m({},Hn),ge);de.autoReplaceSvg||(de.observeMutations=!1);var v={};Object.keys(Hn).forEach(function(e){Object.defineProperty(v,e,{enumerable:!0,set:function(n){de[e]=n,ye.forEach(function(a){return a(v)})},get:function(){return de[e]}})});Object.defineProperty(v,"familyPrefix",{enumerable:!0,set:function(t){de.cssPrefix=t,ye.forEach(function(n){return n(v)})},get:function(){return de.cssPrefix}});Z.FontAwesomeConfig=v;var ye=[];function Lr(e){return ye.push(e),function(){ye.splice(ye.indexOf(e),1)}}var Q=ut,U={size:16,x:0,y:0,rotate:0,flipX:!1,flipY:!1};function $r(e){if(!(!e||!K)){var t=P.createElement("style");t.setAttribute("type","text/css"),t.innerHTML=e;for(var n=P.head.childNodes,a=null,r=n.length-1;r>-1;r--){var i=n[r],o=(i.tagName||"").toUpperCase();["STYLE","LINK"].indexOf(o)>-1&&(a=i)}return P.head.insertBefore(t,a),e}}var Rr="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";function Oe(){for(var e=12,t="";e-- >0;)t+=Rr[Math.random()*62|0];return t}function ve(e){for(var t=[],n=(e||[]).length>>>0;n--;)t[n]=e[n];return t}function Ct(e){return e.classList?ve(e.classList):(e.getAttribute("class")||"").split(" ").filter(function(t){return t})}function Wn(e){return"".concat(e).replace(/&/g,"&amp;").replace(/"/g,"&quot;").replace(/'/g,"&#39;").replace(/</g,"&lt;").replace(/>/g,"&gt;")}function Fr(e){return Object.keys(e||{}).reduce(function(t,n){return t+"".concat(n,'="').concat(Wn(e[n]),'" ')},"").trim()}function Qe(e){return Object.keys(e||{}).reduce(function(t,n){return t+"".concat(n,": ").concat(e[n].trim(),";")},"")}function Nt(e){return e.size!==U.size||e.x!==U.x||e.y!==U.y||e.rotate!==U.rotate||e.flipX||e.flipY}function jr(e){var t=e.transform,n=e.containerWidth,a=e.iconWidth,r={transform:"translate(".concat(n/2," 256)")},i="translate(".concat(t.x*32,", ").concat(t.y*32,") "),o="scale(".concat(t.size/16*(t.flipX?-1:1),", ").concat(t.size/16*(t.flipY?-1:1),") "),s="rotate(".concat(t.rotate," 0 0)"),l={transform:"".concat(i," ").concat(o," ").concat(s)},f={transform:"translate(".concat(a/2*-1," -256)")};return{outer:r,inner:l,path:f}}function Dr(e){var t=e.transform,n=e.width,a=n===void 0?ut:n,r=e.height,i=r===void 0?ut:r,o=e.startCentered,s=o===void 0?!1:o,l="";return s&&jn?l+="translate(".concat(t.x/Q-a/2,"em, ").concat(t.y/Q-i/2,"em) "):s?l+="translate(calc(-50% + ".concat(t.x/Q,"em), calc(-50% + ").concat(t.y/Q,"em)) "):l+="translate(".concat(t.x/Q,"em, ").concat(t.y/Q,"em) "),l+="scale(".concat(t.size/Q*(t.flipX?-1:1),", ").concat(t.size/Q*(t.flipY?-1:1),") "),l+="rotate(".concat(t.rotate,"deg) "),l}var zr=`:root, :host {
  --fa-font-solid: normal 900 1em/1 "Font Awesome 6 Solid";
  --fa-font-regular: normal 400 1em/1 "Font Awesome 6 Regular";
  --fa-font-light: normal 300 1em/1 "Font Awesome 6 Light";
  --fa-font-thin: normal 100 1em/1 "Font Awesome 6 Thin";
  --fa-font-duotone: normal 900 1em/1 "Font Awesome 6 Duotone";
  --fa-font-sharp-solid: normal 900 1em/1 "Font Awesome 6 Sharp";
  --fa-font-sharp-regular: normal 400 1em/1 "Font Awesome 6 Sharp";
  --fa-font-sharp-light: normal 300 1em/1 "Font Awesome 6 Sharp";
  --fa-font-brands: normal 400 1em/1 "Font Awesome 6 Brands";
}

svg:not(:root).svg-inline--fa, svg:not(:host).svg-inline--fa {
  overflow: visible;
  box-sizing: content-box;
}

.svg-inline--fa {
  display: var(--fa-display, inline-block);
  height: 1em;
  overflow: visible;
  vertical-align: -0.125em;
}
.svg-inline--fa.fa-2xs {
  vertical-align: 0.1em;
}
.svg-inline--fa.fa-xs {
  vertical-align: 0em;
}
.svg-inline--fa.fa-sm {
  vertical-align: -0.0714285705em;
}
.svg-inline--fa.fa-lg {
  vertical-align: -0.2em;
}
.svg-inline--fa.fa-xl {
  vertical-align: -0.25em;
}
.svg-inline--fa.fa-2xl {
  vertical-align: -0.3125em;
}
.svg-inline--fa.fa-pull-left {
  margin-right: var(--fa-pull-margin, 0.3em);
  width: auto;
}
.svg-inline--fa.fa-pull-right {
  margin-left: var(--fa-pull-margin, 0.3em);
  width: auto;
}
.svg-inline--fa.fa-li {
  width: var(--fa-li-width, 2em);
  top: 0.25em;
}
.svg-inline--fa.fa-fw {
  width: var(--fa-fw-width, 1.25em);
}

.fa-layers svg.svg-inline--fa {
  bottom: 0;
  left: 0;
  margin: auto;
  position: absolute;
  right: 0;
  top: 0;
}

.fa-layers-counter, .fa-layers-text {
  display: inline-block;
  position: absolute;
  text-align: center;
}

.fa-layers {
  display: inline-block;
  height: 1em;
  position: relative;
  text-align: center;
  vertical-align: -0.125em;
  width: 1em;
}
.fa-layers svg.svg-inline--fa {
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.fa-layers-text {
  left: 50%;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
  -webkit-transform-origin: center center;
          transform-origin: center center;
}

.fa-layers-counter {
  background-color: var(--fa-counter-background-color, #ff253a);
  border-radius: var(--fa-counter-border-radius, 1em);
  box-sizing: border-box;
  color: var(--fa-inverse, #fff);
  line-height: var(--fa-counter-line-height, 1);
  max-width: var(--fa-counter-max-width, 5em);
  min-width: var(--fa-counter-min-width, 1.5em);
  overflow: hidden;
  padding: var(--fa-counter-padding, 0.25em 0.5em);
  right: var(--fa-right, 0);
  text-overflow: ellipsis;
  top: var(--fa-top, 0);
  -webkit-transform: scale(var(--fa-counter-scale, 0.25));
          transform: scale(var(--fa-counter-scale, 0.25));
  -webkit-transform-origin: top right;
          transform-origin: top right;
}

.fa-layers-bottom-right {
  bottom: var(--fa-bottom, 0);
  right: var(--fa-right, 0);
  top: auto;
  -webkit-transform: scale(var(--fa-layers-scale, 0.25));
          transform: scale(var(--fa-layers-scale, 0.25));
  -webkit-transform-origin: bottom right;
          transform-origin: bottom right;
}

.fa-layers-bottom-left {
  bottom: var(--fa-bottom, 0);
  left: var(--fa-left, 0);
  right: auto;
  top: auto;
  -webkit-transform: scale(var(--fa-layers-scale, 0.25));
          transform: scale(var(--fa-layers-scale, 0.25));
  -webkit-transform-origin: bottom left;
          transform-origin: bottom left;
}

.fa-layers-top-right {
  top: var(--fa-top, 0);
  right: var(--fa-right, 0);
  -webkit-transform: scale(var(--fa-layers-scale, 0.25));
          transform: scale(var(--fa-layers-scale, 0.25));
  -webkit-transform-origin: top right;
          transform-origin: top right;
}

.fa-layers-top-left {
  left: var(--fa-left, 0);
  right: auto;
  top: var(--fa-top, 0);
  -webkit-transform: scale(var(--fa-layers-scale, 0.25));
          transform: scale(var(--fa-layers-scale, 0.25));
  -webkit-transform-origin: top left;
          transform-origin: top left;
}

.fa-1x {
  font-size: 1em;
}

.fa-2x {
  font-size: 2em;
}

.fa-3x {
  font-size: 3em;
}

.fa-4x {
  font-size: 4em;
}

.fa-5x {
  font-size: 5em;
}

.fa-6x {
  font-size: 6em;
}

.fa-7x {
  font-size: 7em;
}

.fa-8x {
  font-size: 8em;
}

.fa-9x {
  font-size: 9em;
}

.fa-10x {
  font-size: 10em;
}

.fa-2xs {
  font-size: 0.625em;
  line-height: 0.1em;
  vertical-align: 0.225em;
}

.fa-xs {
  font-size: 0.75em;
  line-height: 0.0833333337em;
  vertical-align: 0.125em;
}

.fa-sm {
  font-size: 0.875em;
  line-height: 0.0714285718em;
  vertical-align: 0.0535714295em;
}

.fa-lg {
  font-size: 1.25em;
  line-height: 0.05em;
  vertical-align: -0.075em;
}

.fa-xl {
  font-size: 1.5em;
  line-height: 0.0416666682em;
  vertical-align: -0.125em;
}

.fa-2xl {
  font-size: 2em;
  line-height: 0.03125em;
  vertical-align: -0.1875em;
}

.fa-fw {
  text-align: center;
  width: 1.25em;
}

.fa-ul {
  list-style-type: none;
  margin-left: var(--fa-li-margin, 2.5em);
  padding-left: 0;
}
.fa-ul > li {
  position: relative;
}

.fa-li {
  left: calc(var(--fa-li-width, 2em) * -1);
  position: absolute;
  text-align: center;
  width: var(--fa-li-width, 2em);
  line-height: inherit;
}

.fa-border {
  border-color: var(--fa-border-color, #eee);
  border-radius: var(--fa-border-radius, 0.1em);
  border-style: var(--fa-border-style, solid);
  border-width: var(--fa-border-width, 0.08em);
  padding: var(--fa-border-padding, 0.2em 0.25em 0.15em);
}

.fa-pull-left {
  float: left;
  margin-right: var(--fa-pull-margin, 0.3em);
}

.fa-pull-right {
  float: right;
  margin-left: var(--fa-pull-margin, 0.3em);
}

.fa-beat {
  -webkit-animation-name: fa-beat;
          animation-name: fa-beat;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, ease-in-out);
          animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-bounce {
  -webkit-animation-name: fa-bounce;
          animation-name: fa-bounce;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.28, 0.84, 0.42, 1));
          animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.28, 0.84, 0.42, 1));
}

.fa-fade {
  -webkit-animation-name: fa-fade;
          animation-name: fa-fade;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));
          animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));
}

.fa-beat-fade {
  -webkit-animation-name: fa-beat-fade;
          animation-name: fa-beat-fade;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));
          animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));
}

.fa-flip {
  -webkit-animation-name: fa-flip;
          animation-name: fa-flip;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, ease-in-out);
          animation-timing-function: var(--fa-animation-timing, ease-in-out);
}

.fa-shake {
  -webkit-animation-name: fa-shake;
          animation-name: fa-shake;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, linear);
          animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-spin {
  -webkit-animation-name: fa-spin;
          animation-name: fa-spin;
  -webkit-animation-delay: var(--fa-animation-delay, 0s);
          animation-delay: var(--fa-animation-delay, 0s);
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 2s);
          animation-duration: var(--fa-animation-duration, 2s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, linear);
          animation-timing-function: var(--fa-animation-timing, linear);
}

.fa-spin-reverse {
  --fa-animation-direction: reverse;
}

.fa-pulse,
.fa-spin-pulse {
  -webkit-animation-name: fa-spin;
          animation-name: fa-spin;
  -webkit-animation-direction: var(--fa-animation-direction, normal);
          animation-direction: var(--fa-animation-direction, normal);
  -webkit-animation-duration: var(--fa-animation-duration, 1s);
          animation-duration: var(--fa-animation-duration, 1s);
  -webkit-animation-iteration-count: var(--fa-animation-iteration-count, infinite);
          animation-iteration-count: var(--fa-animation-iteration-count, infinite);
  -webkit-animation-timing-function: var(--fa-animation-timing, steps(8));
          animation-timing-function: var(--fa-animation-timing, steps(8));
}

@media (prefers-reduced-motion: reduce) {
  .fa-beat,
.fa-bounce,
.fa-fade,
.fa-beat-fade,
.fa-flip,
.fa-pulse,
.fa-shake,
.fa-spin,
.fa-spin-pulse {
    -webkit-animation-delay: -1ms;
            animation-delay: -1ms;
    -webkit-animation-duration: 1ms;
            animation-duration: 1ms;
    -webkit-animation-iteration-count: 1;
            animation-iteration-count: 1;
    -webkit-transition-delay: 0s;
            transition-delay: 0s;
    -webkit-transition-duration: 0s;
            transition-duration: 0s;
  }
}
@-webkit-keyframes fa-beat {
  0%, 90% {
    -webkit-transform: scale(1);
            transform: scale(1);
  }
  45% {
    -webkit-transform: scale(var(--fa-beat-scale, 1.25));
            transform: scale(var(--fa-beat-scale, 1.25));
  }
}
@keyframes fa-beat {
  0%, 90% {
    -webkit-transform: scale(1);
            transform: scale(1);
  }
  45% {
    -webkit-transform: scale(var(--fa-beat-scale, 1.25));
            transform: scale(var(--fa-beat-scale, 1.25));
  }
}
@-webkit-keyframes fa-bounce {
  0% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
  10% {
    -webkit-transform: scale(var(--fa-bounce-start-scale-x, 1.1), var(--fa-bounce-start-scale-y, 0.9)) translateY(0);
            transform: scale(var(--fa-bounce-start-scale-x, 1.1), var(--fa-bounce-start-scale-y, 0.9)) translateY(0);
  }
  30% {
    -webkit-transform: scale(var(--fa-bounce-jump-scale-x, 0.9), var(--fa-bounce-jump-scale-y, 1.1)) translateY(var(--fa-bounce-height, -0.5em));
            transform: scale(var(--fa-bounce-jump-scale-x, 0.9), var(--fa-bounce-jump-scale-y, 1.1)) translateY(var(--fa-bounce-height, -0.5em));
  }
  50% {
    -webkit-transform: scale(var(--fa-bounce-land-scale-x, 1.05), var(--fa-bounce-land-scale-y, 0.95)) translateY(0);
            transform: scale(var(--fa-bounce-land-scale-x, 1.05), var(--fa-bounce-land-scale-y, 0.95)) translateY(0);
  }
  57% {
    -webkit-transform: scale(1, 1) translateY(var(--fa-bounce-rebound, -0.125em));
            transform: scale(1, 1) translateY(var(--fa-bounce-rebound, -0.125em));
  }
  64% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
  100% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
}
@keyframes fa-bounce {
  0% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
  10% {
    -webkit-transform: scale(var(--fa-bounce-start-scale-x, 1.1), var(--fa-bounce-start-scale-y, 0.9)) translateY(0);
            transform: scale(var(--fa-bounce-start-scale-x, 1.1), var(--fa-bounce-start-scale-y, 0.9)) translateY(0);
  }
  30% {
    -webkit-transform: scale(var(--fa-bounce-jump-scale-x, 0.9), var(--fa-bounce-jump-scale-y, 1.1)) translateY(var(--fa-bounce-height, -0.5em));
            transform: scale(var(--fa-bounce-jump-scale-x, 0.9), var(--fa-bounce-jump-scale-y, 1.1)) translateY(var(--fa-bounce-height, -0.5em));
  }
  50% {
    -webkit-transform: scale(var(--fa-bounce-land-scale-x, 1.05), var(--fa-bounce-land-scale-y, 0.95)) translateY(0);
            transform: scale(var(--fa-bounce-land-scale-x, 1.05), var(--fa-bounce-land-scale-y, 0.95)) translateY(0);
  }
  57% {
    -webkit-transform: scale(1, 1) translateY(var(--fa-bounce-rebound, -0.125em));
            transform: scale(1, 1) translateY(var(--fa-bounce-rebound, -0.125em));
  }
  64% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
  100% {
    -webkit-transform: scale(1, 1) translateY(0);
            transform: scale(1, 1) translateY(0);
  }
}
@-webkit-keyframes fa-fade {
  50% {
    opacity: var(--fa-fade-opacity, 0.4);
  }
}
@keyframes fa-fade {
  50% {
    opacity: var(--fa-fade-opacity, 0.4);
  }
}
@-webkit-keyframes fa-beat-fade {
  0%, 100% {
    opacity: var(--fa-beat-fade-opacity, 0.4);
    -webkit-transform: scale(1);
            transform: scale(1);
  }
  50% {
    opacity: 1;
    -webkit-transform: scale(var(--fa-beat-fade-scale, 1.125));
            transform: scale(var(--fa-beat-fade-scale, 1.125));
  }
}
@keyframes fa-beat-fade {
  0%, 100% {
    opacity: var(--fa-beat-fade-opacity, 0.4);
    -webkit-transform: scale(1);
            transform: scale(1);
  }
  50% {
    opacity: 1;
    -webkit-transform: scale(var(--fa-beat-fade-scale, 1.125));
            transform: scale(var(--fa-beat-fade-scale, 1.125));
  }
}
@-webkit-keyframes fa-flip {
  50% {
    -webkit-transform: rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -180deg));
            transform: rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -180deg));
  }
}
@keyframes fa-flip {
  50% {
    -webkit-transform: rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -180deg));
            transform: rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -180deg));
  }
}
@-webkit-keyframes fa-shake {
  0% {
    -webkit-transform: rotate(-15deg);
            transform: rotate(-15deg);
  }
  4% {
    -webkit-transform: rotate(15deg);
            transform: rotate(15deg);
  }
  8%, 24% {
    -webkit-transform: rotate(-18deg);
            transform: rotate(-18deg);
  }
  12%, 28% {
    -webkit-transform: rotate(18deg);
            transform: rotate(18deg);
  }
  16% {
    -webkit-transform: rotate(-22deg);
            transform: rotate(-22deg);
  }
  20% {
    -webkit-transform: rotate(22deg);
            transform: rotate(22deg);
  }
  32% {
    -webkit-transform: rotate(-12deg);
            transform: rotate(-12deg);
  }
  36% {
    -webkit-transform: rotate(12deg);
            transform: rotate(12deg);
  }
  40%, 100% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
}
@keyframes fa-shake {
  0% {
    -webkit-transform: rotate(-15deg);
            transform: rotate(-15deg);
  }
  4% {
    -webkit-transform: rotate(15deg);
            transform: rotate(15deg);
  }
  8%, 24% {
    -webkit-transform: rotate(-18deg);
            transform: rotate(-18deg);
  }
  12%, 28% {
    -webkit-transform: rotate(18deg);
            transform: rotate(18deg);
  }
  16% {
    -webkit-transform: rotate(-22deg);
            transform: rotate(-22deg);
  }
  20% {
    -webkit-transform: rotate(22deg);
            transform: rotate(22deg);
  }
  32% {
    -webkit-transform: rotate(-12deg);
            transform: rotate(-12deg);
  }
  36% {
    -webkit-transform: rotate(12deg);
            transform: rotate(12deg);
  }
  40%, 100% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
}
@-webkit-keyframes fa-spin {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
  }
}
@keyframes fa-spin {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
  }
}
.fa-rotate-90 {
  -webkit-transform: rotate(90deg);
          transform: rotate(90deg);
}

.fa-rotate-180 {
  -webkit-transform: rotate(180deg);
          transform: rotate(180deg);
}

.fa-rotate-270 {
  -webkit-transform: rotate(270deg);
          transform: rotate(270deg);
}

.fa-flip-horizontal {
  -webkit-transform: scale(-1, 1);
          transform: scale(-1, 1);
}

.fa-flip-vertical {
  -webkit-transform: scale(1, -1);
          transform: scale(1, -1);
}

.fa-flip-both,
.fa-flip-horizontal.fa-flip-vertical {
  -webkit-transform: scale(-1, -1);
          transform: scale(-1, -1);
}

.fa-rotate-by {
  -webkit-transform: rotate(var(--fa-rotate-angle, none));
          transform: rotate(var(--fa-rotate-angle, none));
}

.fa-stack {
  display: inline-block;
  vertical-align: middle;
  height: 2em;
  position: relative;
  width: 2.5em;
}

.fa-stack-1x,
.fa-stack-2x {
  bottom: 0;
  left: 0;
  margin: auto;
  position: absolute;
  right: 0;
  top: 0;
  z-index: var(--fa-stack-z-index, auto);
}

.svg-inline--fa.fa-stack-1x {
  height: 1em;
  width: 1.25em;
}
.svg-inline--fa.fa-stack-2x {
  height: 2em;
  width: 2.5em;
}

.fa-inverse {
  color: var(--fa-inverse, #fff);
}

.sr-only,
.fa-sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}

.sr-only-focusable:not(:focus),
.fa-sr-only-focusable:not(:focus) {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}

.svg-inline--fa .fa-primary {
  fill: var(--fa-primary-color, currentColor);
  opacity: var(--fa-primary-opacity, 1);
}

.svg-inline--fa .fa-secondary {
  fill: var(--fa-secondary-color, currentColor);
  opacity: var(--fa-secondary-opacity, 0.4);
}

.svg-inline--fa.fa-swap-opacity .fa-primary {
  opacity: var(--fa-secondary-opacity, 0.4);
}

.svg-inline--fa.fa-swap-opacity .fa-secondary {
  opacity: var(--fa-primary-opacity, 1);
}

.svg-inline--fa mask .fa-primary,
.svg-inline--fa mask .fa-secondary {
  fill: black;
}

.fad.fa-inverse,
.fa-duotone.fa-inverse {
  color: var(--fa-inverse, #fff);
}`;function Xn(){var e=Dn,t=zn,n=v.cssPrefix,a=v.replacementClass,r=zr;if(n!==e||a!==t){var i=new RegExp("\\.".concat(e,"\\-"),"g"),o=new RegExp("\\--".concat(e,"\\-"),"g"),s=new RegExp("\\.".concat(t),"g");r=r.replace(i,".".concat(n,"-")).replace(o,"--".concat(n,"-")).replace(s,".".concat(a))}return r}var nn=!1;function it(){v.autoAddCss&&!nn&&($r(Xn()),nn=!0)}var Yr={mixout:function(){return{dom:{css:Xn,insertCss:it}}},hooks:function(){return{beforeDOMElementCreation:function(){it()},beforeI2svg:function(){it()}}}},B=Z||{};B[G]||(B[G]={});B[G].styles||(B[G].styles={});B[G].hooks||(B[G].hooks={});B[G].shims||(B[G].shims=[]);var z=B[G],Gn=[],Vr=function e(){P.removeEventListener("DOMContentLoaded",e),Xe=1,Gn.map(function(t){return t()})},Xe=!1;K&&(Xe=(P.documentElement.doScroll?/^loaded|^c/:/^loaded|^i|^c/).test(P.readyState),Xe||P.addEventListener("DOMContentLoaded",Vr));function Ur(e){K&&(Xe?setTimeout(e,0):Gn.push(e))}function Pe(e){var t=e.tag,n=e.attributes,a=n===void 0?{}:n,r=e.children,i=r===void 0?[]:r;return typeof e=="string"?Wn(e):"<".concat(t," ").concat(Fr(a),">").concat(i.map(Pe).join(""),"</").concat(t,">")}function an(e,t,n){if(e&&e[t]&&e[t][n])return{prefix:t,iconName:n,icon:e[t][n]}}var Hr=function(t,n){return function(a,r,i,o){return t.call(n,a,r,i,o)}},ot=function(t,n,a,r){var i=Object.keys(t),o=i.length,s=r!==void 0?Hr(n,r):n,l,f,c;for(a===void 0?(l=1,c=t[i[0]]):(l=0,c=a);l<o;l++)f=i[l],c=s(c,t[f],f,t);return c};function Wr(e){for(var t=[],n=0,a=e.length;n<a;){var r=e.charCodeAt(n++);if(r>=55296&&r<=56319&&n<a){var i=e.charCodeAt(n++);(i&64512)==56320?t.push(((r&1023)<<10)+(i&1023)+65536):(t.push(r),n--)}else t.push(r)}return t}function dt(e){var t=Wr(e);return t.length===1?t[0].toString(16):null}function Xr(e,t){var n=e.length,a=e.charCodeAt(t),r;return a>=55296&&a<=56319&&n>t+1&&(r=e.charCodeAt(t+1),r>=56320&&r<=57343)?(a-55296)*1024+r-56320+65536:a}function rn(e){return Object.keys(e).reduce(function(t,n){var a=e[n],r=!!a.icon;return r?t[a.iconName]=a.icon:t[n]=a,t},{})}function vt(e,t){var n=arguments.length>2&&arguments[2]!==void 0?arguments[2]:{},a=n.skipHooks,r=a===void 0?!1:a,i=rn(t);typeof z.hooks.addPack=="function"&&!r?z.hooks.addPack(e,rn(t)):z.styles[e]=m(m({},z.styles[e]||{}),i),e==="fas"&&vt("fa",t)}var Fe,je,De,fe=z.styles,Gr=z.shims,Br=(Fe={},N(Fe,A,Object.values(ke[A])),N(Fe,_,Object.values(ke[_])),Fe),It=null,Bn={},qn={},Kn={},Qn={},Jn={},qr=(je={},N(je,A,Object.keys(he[A])),N(je,_,Object.keys(he[_])),je);function Kr(e){return~Nr.indexOf(e)}function Qr(e,t){var n=t.split("-"),a=n[0],r=n.slice(1).join("-");return a===e&&r!==""&&!Kr(r)?r:null}var Zn=function(){var t=function(i){return ot(fe,function(o,s,l){return o[l]=ot(s,i,{}),o},{})};Bn=t(function(r,i,o){if(i[3]&&(r[i[3]]=o),i[2]){var s=i[2].filter(function(l){return typeof l=="number"});s.forEach(function(l){r[l.toString(16)]=o})}return r}),qn=t(function(r,i,o){if(r[o]=o,i[2]){var s=i[2].filter(function(l){return typeof l=="string"});s.forEach(function(l){r[l]=o})}return r}),Jn=t(function(r,i,o){var s=i[2];return r[o]=o,s.forEach(function(l){r[l]=o}),r});var n="far"in fe||v.autoFetchSvg,a=ot(Gr,function(r,i){var o=i[0],s=i[1],l=i[2];return s==="far"&&!n&&(s="fas"),typeof o=="string"&&(r.names[o]={prefix:s,iconName:l}),typeof o=="number"&&(r.unicodes[o.toString(16)]={prefix:s,iconName:l}),r},{names:{},unicodes:{}});Kn=a.names,Qn=a.unicodes,It=Je(v.styleDefault,{family:v.familyDefault})};Lr(function(e){It=Je(e.styleDefault,{family:v.familyDefault})});Zn();function Tt(e,t){return(Bn[e]||{})[t]}function Jr(e,t){return(qn[e]||{})[t]}function ie(e,t){return(Jn[e]||{})[t]}function ea(e){return Kn[e]||{prefix:null,iconName:null}}function Zr(e){var t=Qn[e],n=Tt("fas",e);return t||(n?{prefix:"fas",iconName:n}:null)||{prefix:null,iconName:null}}function ee(){return It}var Mt=function(){return{prefix:null,iconName:null,rest:[]}};function Je(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},n=t.family,a=n===void 0?A:n,r=he[a][e],i=we[a][e]||we[a][r],o=e in z.styles?e:null;return i||o||null}var on=(De={},N(De,A,Object.keys(ke[A])),N(De,_,Object.keys(ke[_])),De);function Ze(e){var t,n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},a=n.skipLookups,r=a===void 0?!1:a,i=(t={},N(t,A,"".concat(v.cssPrefix,"-").concat(A)),N(t,_,"".concat(v.cssPrefix,"-").concat(_)),t),o=null,s=A;(e.includes(i[A])||e.some(function(f){return on[A].includes(f)}))&&(s=A),(e.includes(i[_])||e.some(function(f){return on[_].includes(f)}))&&(s=_);var l=e.reduce(function(f,c){var u=Qr(v.cssPrefix,c);if(fe[c]?(c=Br[s].includes(c)?Sr[s][c]:c,o=c,f.prefix=c):qr[s].indexOf(c)>-1?(o=c,f.prefix=Je(c,{family:s})):u?f.iconName=u:c!==v.replacementClass&&c!==i[A]&&c!==i[_]&&f.rest.push(c),!r&&f.prefix&&f.iconName){var d=o==="fa"?ea(f.iconName):{},p=ie(f.prefix,f.iconName);d.prefix&&(o=null),f.iconName=d.iconName||p||f.iconName,f.prefix=d.prefix||f.prefix,f.prefix==="far"&&!fe.far&&fe.fas&&!v.autoFetchSvg&&(f.prefix="fas")}return f},Mt());return(e.includes("fa-brands")||e.includes("fab"))&&(l.prefix="fab"),(e.includes("fa-duotone")||e.includes("fad"))&&(l.prefix="fad"),!l.prefix&&s===_&&(fe.fass||v.autoFetchSvg)&&(l.prefix="fass",l.iconName=ie(l.prefix,l.iconName)||l.iconName),(l.prefix==="fa"||o==="fa")&&(l.prefix=ee()||"fas"),l}var ei=function(){function e(){mr(this,e),this.definitions={}}return dr(e,[{key:"add",value:function(){for(var n=this,a=arguments.length,r=new Array(a),i=0;i<a;i++)r[i]=arguments[i];var o=r.reduce(this._pullDefinitions,{});Object.keys(o).forEach(function(s){n.definitions[s]=m(m({},n.definitions[s]||{}),o[s]),vt(s,o[s]);var l=ke[A][s];l&&vt(l,o[s]),Zn()})}},{key:"reset",value:function(){this.definitions={}}},{key:"_pullDefinitions",value:function(n,a){var r=a.prefix&&a.iconName&&a.icon?{0:a}:a;return Object.keys(r).map(function(i){var o=r[i],s=o.prefix,l=o.iconName,f=o.icon,c=f[2];n[s]||(n[s]={}),c.length>0&&c.forEach(function(u){typeof u=="string"&&(n[s][u]=f)}),n[s][l]=f}),n}}]),e}(),sn=[],ce={},me={},ti=Object.keys(me);function ni(e,t){var n=t.mixoutsTo;return sn=e,ce={},Object.keys(me).forEach(function(a){ti.indexOf(a)===-1&&delete me[a]}),sn.forEach(function(a){var r=a.mixout?a.mixout():{};if(Object.keys(r).forEach(function(o){typeof r[o]=="function"&&(n[o]=r[o]),We(r[o])==="object"&&Object.keys(r[o]).forEach(function(s){n[o]||(n[o]={}),n[o][s]=r[o][s]})}),a.hooks){var i=a.hooks();Object.keys(i).forEach(function(o){ce[o]||(ce[o]=[]),ce[o].push(i[o])})}a.provides&&a.provides(me)}),n}function pt(e,t){for(var n=arguments.length,a=new Array(n>2?n-2:0),r=2;r<n;r++)a[r-2]=arguments[r];var i=ce[e]||[];return i.forEach(function(o){t=o.apply(null,[t].concat(a))}),t}function se(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),a=1;a<t;a++)n[a-1]=arguments[a];var r=ce[e]||[];r.forEach(function(i){i.apply(null,n)})}function q(){var e=arguments[0],t=Array.prototype.slice.call(arguments,1);return me[e]?me[e].apply(null,t):void 0}function bt(e){e.prefix==="fa"&&(e.prefix="fas");var t=e.iconName,n=e.prefix||ee();if(t)return t=ie(n,t)||t,an(ta.definitions,n,t)||an(z.styles,n,t)}var ta=new ei,ai=function(){v.autoReplaceSvg=!1,v.observeMutations=!1,se("noAuto")},ri={i2svg:function(){var t=arguments.length>0&&arguments[0]!==void 0?arguments[0]:{};return K?(se("beforeI2svg",t),q("pseudoElements2svg",t),q("i2svg",t)):Promise.reject("Operation requires a DOM of some kind.")},watch:function(){var t=arguments.length>0&&arguments[0]!==void 0?arguments[0]:{},n=t.autoReplaceSvgRoot;v.autoReplaceSvg===!1&&(v.autoReplaceSvg=!0),v.observeMutations=!0,Ur(function(){oi({autoReplaceSvgRoot:n}),se("watch",t)})}},ii={icon:function(t){if(t===null)return null;if(We(t)==="object"&&t.prefix&&t.iconName)return{prefix:t.prefix,iconName:ie(t.prefix,t.iconName)||t.iconName};if(Array.isArray(t)&&t.length===2){var n=t[1].indexOf("fa-")===0?t[1].slice(3):t[1],a=Je(t[0]);return{prefix:a,iconName:ie(a,n)||n}}if(typeof t=="string"&&(t.indexOf("".concat(v.cssPrefix,"-"))>-1||t.match(Ar))){var r=Ze(t.split(" "),{skipLookups:!0});return{prefix:r.prefix||ee(),iconName:ie(r.prefix,r.iconName)||r.iconName}}if(typeof t=="string"){var i=ee();return{prefix:i,iconName:ie(i,t)||t}}}},$={noAuto:ai,config:v,dom:ri,parse:ii,library:ta,findIconDefinition:bt,toHtml:Pe},oi=function(){var t=arguments.length>0&&arguments[0]!==void 0?arguments[0]:{},n=t.autoReplaceSvgRoot,a=n===void 0?P:n;(Object.keys(z.styles).length>0||v.autoFetchSvg)&&K&&v.autoReplaceSvg&&$.dom.i2svg({node:a})};function et(e,t){return Object.defineProperty(e,"abstract",{get:t}),Object.defineProperty(e,"html",{get:function(){return e.abstract.map(function(a){return Pe(a)})}}),Object.defineProperty(e,"node",{get:function(){if(K){var a=P.createElement("div");return a.innerHTML=e.html,a.children}}}),e}function si(e){var t=e.children,n=e.main,a=e.mask,r=e.attributes,i=e.styles,o=e.transform;if(Nt(o)&&n.found&&!a.found){var s=n.width,l=n.height,f={x:s/l/2,y:.5};r.style=Qe(m(m({},i),{},{"transform-origin":"".concat(f.x+o.x/16,"em ").concat(f.y+o.y/16,"em")}))}return[{tag:"svg",attributes:r,children:t}]}function li(e){var t=e.prefix,n=e.iconName,a=e.children,r=e.attributes,i=e.symbol,o=i===!0?"".concat(t,"-").concat(v.cssPrefix,"-").concat(n):i;return[{tag:"svg",attributes:{style:"display: none;"},children:[{tag:"symbol",attributes:m(m({},r),{},{id:o}),children:a}]}]}function Lt(e){var t=e.icons,n=t.main,a=t.mask,r=e.prefix,i=e.iconName,o=e.transform,s=e.symbol,l=e.title,f=e.maskId,c=e.titleId,u=e.extra,d=e.watchable,p=d===void 0?!1:d,h=a.found?a:n,y=h.width,w=h.height,x=r==="fak",b=[v.replacementClass,i?"".concat(v.cssPrefix,"-").concat(i):""].filter(function(R){return u.classes.indexOf(R)===-1}).filter(function(R){return R!==""||!!R}).concat(u.classes).join(" "),O={children:[],attributes:m(m({},u.attributes),{},{"data-prefix":r,"data-icon":i,class:b,role:u.attributes.role||"img",xmlns:"http://www.w3.org/2000/svg",viewBox:"0 0 ".concat(y," ").concat(w)})},k=x&&!~u.classes.indexOf("fa-fw")?{width:"".concat(y/w*16*.0625,"em")}:{};p&&(O.attributes[oe]=""),l&&(O.children.push({tag:"title",attributes:{id:O.attributes["aria-labelledby"]||"title-".concat(c||Oe())},children:[l]}),delete O.attributes.title);var S=m(m({},O),{},{prefix:r,iconName:i,main:n,mask:a,maskId:f,transform:o,symbol:s,styles:m(m({},k),u.styles)}),j=a.found&&n.found?q("generateAbstractMask",S)||{children:[],attributes:{}}:q("generateAbstractIcon",S)||{children:[],attributes:{}},D=j.children,H=j.attributes;return S.children=D,S.attributes=H,s?li(S):si(S)}function ln(e){var t=e.content,n=e.width,a=e.height,r=e.transform,i=e.title,o=e.extra,s=e.watchable,l=s===void 0?!1:s,f=m(m(m({},o.attributes),i?{title:i}:{}),{},{class:o.classes.join(" ")});l&&(f[oe]="");var c=m({},o.styles);Nt(r)&&(c.transform=Dr({transform:r,startCentered:!0,width:n,height:a}),c["-webkit-transform"]=c.transform);var u=Qe(c);u.length>0&&(f.style=u);var d=[];return d.push({tag:"span",attributes:f,children:[t]}),i&&d.push({tag:"span",attributes:{class:"sr-only"},children:[i]}),d}function fi(e){var t=e.content,n=e.title,a=e.extra,r=m(m(m({},a.attributes),n?{title:n}:{}),{},{class:a.classes.join(" ")}),i=Qe(a.styles);i.length>0&&(r.style=i);var o=[];return o.push({tag:"span",attributes:r,children:[t]}),n&&o.push({tag:"span",attributes:{class:"sr-only"},children:[n]}),o}var st=z.styles;function gt(e){var t=e[0],n=e[1],a=e.slice(4),r=St(a,1),i=r[0],o=null;return Array.isArray(i)?o={tag:"g",attributes:{class:"".concat(v.cssPrefix,"-").concat(re.GROUP)},children:[{tag:"path",attributes:{class:"".concat(v.cssPrefix,"-").concat(re.SECONDARY),fill:"currentColor",d:i[0]}},{tag:"path",attributes:{class:"".concat(v.cssPrefix,"-").concat(re.PRIMARY),fill:"currentColor",d:i[1]}}]}:o={tag:"path",attributes:{fill:"currentColor",d:i}},{found:!0,width:t,height:n,icon:o}}var ci={found:!1,width:512,height:512};function ui(e,t){!Yn&&!v.showMissingIcons&&e&&console.error('Icon with name "'.concat(e,'" and prefix "').concat(t,'" is missing.'))}function yt(e,t){var n=t;return t==="fa"&&v.styleDefault!==null&&(t=ee()),new Promise(function(a,r){if(q("missingIconAbstract"),n==="fa"){var i=ea(e)||{};e=i.iconName||e,t=i.prefix||t}if(e&&t&&st[t]&&st[t][e]){var o=st[t][e];return a(gt(o))}ui(e,t),a(m(m({},ci),{},{icon:v.showMissingIcons&&e?q("missingIconAbstract")||{}:{}}))})}var fn=function(){},ht=v.measurePerformance&&Ie&&Ie.mark&&Ie.measure?Ie:{mark:fn,measure:fn},pe='FA "6.4.0"',mi=function(t){return ht.mark("".concat(pe," ").concat(t," begins")),function(){return na(t)}},na=function(t){ht.mark("".concat(pe," ").concat(t," ends")),ht.measure("".concat(pe," ").concat(t),"".concat(pe," ").concat(t," begins"),"".concat(pe," ").concat(t," ends"))},$t={begin:mi,end:na},ze=function(){};function cn(e){var t=e.getAttribute?e.getAttribute(oe):null;return typeof t=="string"}function di(e){var t=e.getAttribute?e.getAttribute(Pt):null,n=e.getAttribute?e.getAttribute(_t):null;return t&&n}function vi(e){return e&&e.classList&&e.classList.contains&&e.classList.contains(v.replacementClass)}function pi(){if(v.autoReplaceSvg===!0)return Ye.replace;var e=Ye[v.autoReplaceSvg];return e||Ye.replace}function bi(e){return P.createElementNS("http://www.w3.org/2000/svg",e)}function gi(e){return P.createElement(e)}function aa(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},n=t.ceFn,a=n===void 0?e.tag==="svg"?bi:gi:n;if(typeof e=="string")return P.createTextNode(e);var r=a(e.tag);Object.keys(e.attributes||[]).forEach(function(o){r.setAttribute(o,e.attributes[o])});var i=e.children||[];return i.forEach(function(o){r.appendChild(aa(o,{ceFn:a}))}),r}function yi(e){var t=" ".concat(e.outerHTML," ");return t="".concat(t,"Font Awesome fontawesome.com "),t}var Ye={replace:function(t){var n=t[0];if(n.parentNode)if(t[1].forEach(function(r){n.parentNode.insertBefore(aa(r),n)}),n.getAttribute(oe)===null&&v.keepOriginalSource){var a=P.createComment(yi(n));n.parentNode.replaceChild(a,n)}else n.remove()},nest:function(t){var n=t[0],a=t[1];if(~Ct(n).indexOf(v.replacementClass))return Ye.replace(t);var r=new RegExp("".concat(v.cssPrefix,"-.*"));if(delete a[0].attributes.id,a[0].attributes.class){var i=a[0].attributes.class.split(" ").reduce(function(s,l){return l===v.replacementClass||l.match(r)?s.toSvg.push(l):s.toNode.push(l),s},{toNode:[],toSvg:[]});a[0].attributes.class=i.toSvg.join(" "),i.toNode.length===0?n.removeAttribute("class"):n.setAttribute("class",i.toNode.join(" "))}var o=a.map(function(s){return Pe(s)}).join(`
`);n.setAttribute(oe,""),n.innerHTML=o}};function un(e){e()}function ra(e,t){var n=typeof t=="function"?t:ze;if(e.length===0)n();else{var a=un;v.mutateApproach===xr&&(a=Z.requestAnimationFrame||un),a(function(){var r=pi(),i=$t.begin("mutate");e.map(r),i(),n()})}}var Rt=!1;function ia(){Rt=!0}function wt(){Rt=!1}var Ge=null;function mn(e){if(en&&v.observeMutations){var t=e.treeCallback,n=t===void 0?ze:t,a=e.nodeCallback,r=a===void 0?ze:a,i=e.pseudoElementsCallback,o=i===void 0?ze:i,s=e.observeMutationsRoot,l=s===void 0?P:s;Ge=new en(function(f){if(!Rt){var c=ee();ve(f).forEach(function(u){if(u.type==="childList"&&u.addedNodes.length>0&&!cn(u.addedNodes[0])&&(v.searchPseudoElements&&o(u.target),n(u.target)),u.type==="attributes"&&u.target.parentNode&&v.searchPseudoElements&&o(u.target.parentNode),u.type==="attributes"&&cn(u.target)&&~Cr.indexOf(u.attributeName))if(u.attributeName==="class"&&di(u.target)){var d=Ze(Ct(u.target)),p=d.prefix,h=d.iconName;u.target.setAttribute(Pt,p||c),h&&u.target.setAttribute(_t,h)}else vi(u.target)&&r(u.target)})}}),K&&Ge.observe(l,{childList:!0,attributes:!0,characterData:!0,subtree:!0})}}function hi(){Ge&&Ge.disconnect()}function wi(e){var t=e.getAttribute("style"),n=[];return t&&(n=t.split(";").reduce(function(a,r){var i=r.split(":"),o=i[0],s=i.slice(1);return o&&s.length>0&&(a[o]=s.join(":").trim()),a},{})),n}function ki(e){var t=e.getAttribute("data-prefix"),n=e.getAttribute("data-icon"),a=e.innerText!==void 0?e.innerText.trim():"",r=Ze(Ct(e));return r.prefix||(r.prefix=ee()),t&&n&&(r.prefix=t,r.iconName=n),r.iconName&&r.prefix||(r.prefix&&a.length>0&&(r.iconName=Jr(r.prefix,e.innerText)||Tt(r.prefix,dt(e.innerText))),!r.iconName&&v.autoFetchSvg&&e.firstChild&&e.firstChild.nodeType===Node.TEXT_NODE&&(r.iconName=e.firstChild.data)),r}function xi(e){var t=ve(e.attributes).reduce(function(r,i){return r.name!=="class"&&r.name!=="style"&&(r[i.name]=i.value),r},{}),n=e.getAttribute("title"),a=e.getAttribute("data-fa-title-id");return v.autoA11y&&(n?t["aria-labelledby"]="".concat(v.replacementClass,"-title-").concat(a||Oe()):(t["aria-hidden"]="true",t.focusable="false")),t}function Oi(){return{iconName:null,title:null,titleId:null,prefix:null,transform:U,symbol:!1,mask:{iconName:null,prefix:null,rest:[]},maskId:null,extra:{classes:[],styles:{},attributes:{}}}}function dn(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{styleParser:!0},n=ki(e),a=n.iconName,r=n.prefix,i=n.rest,o=xi(e),s=pt("parseNodeAttributes",{},e),l=t.styleParser?wi(e):[];return m({iconName:a,title:e.getAttribute("title"),titleId:e.getAttribute("data-fa-title-id"),prefix:r,transform:U,mask:{iconName:null,prefix:null,rest:[]},maskId:null,symbol:!1,extra:{classes:i,styles:l,attributes:o}},s)}var Si=z.styles;function oa(e){var t=v.autoReplaceSvg==="nest"?dn(e,{styleParser:!1}):dn(e);return~t.extra.classes.indexOf(Vn)?q("generateLayersText",e,t):q("generateSvgReplacementMutation",e,t)}var te=new Set;Et.map(function(e){te.add("fa-".concat(e))});Object.keys(he[A]).map(te.add.bind(te));Object.keys(he[_]).map(te.add.bind(te));te=Se(te);function vn(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:null;if(!K)return Promise.resolve();var n=P.documentElement.classList,a=function(u){return n.add("".concat(tn,"-").concat(u))},r=function(u){return n.remove("".concat(tn,"-").concat(u))},i=v.autoFetchSvg?te:Et.map(function(c){return"fa-".concat(c)}).concat(Object.keys(Si));i.includes("fa")||i.push("fa");var o=[".".concat(Vn,":not([").concat(oe,"])")].concat(i.map(function(c){return".".concat(c,":not([").concat(oe,"])")})).join(", ");if(o.length===0)return Promise.resolve();var s=[];try{s=ve(e.querySelectorAll(o))}catch{}if(s.length>0)a("pending"),r("complete");else return Promise.resolve();var l=$t.begin("onTree"),f=s.reduce(function(c,u){try{var d=oa(u);d&&c.push(d)}catch(p){Yn||p.name==="MissingIcon"&&console.error(p)}return c},[]);return new Promise(function(c,u){Promise.all(f).then(function(d){ra(d,function(){a("active"),a("complete"),r("pending"),typeof t=="function"&&t(),l(),c()})}).catch(function(d){l(),u(d)})})}function Ai(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:null;oa(e).then(function(n){n&&ra([n],t)})}function Pi(e){return function(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},a=(t||{}).icon?t:bt(t||{}),r=n.mask;return r&&(r=(r||{}).icon?r:bt(r||{})),e(a,m(m({},n),{},{mask:r}))}}var _i=function(t){var n=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},a=n.transform,r=a===void 0?U:a,i=n.symbol,o=i===void 0?!1:i,s=n.mask,l=s===void 0?null:s,f=n.maskId,c=f===void 0?null:f,u=n.title,d=u===void 0?null:u,p=n.titleId,h=p===void 0?null:p,y=n.classes,w=y===void 0?[]:y,x=n.attributes,b=x===void 0?{}:x,O=n.styles,k=O===void 0?{}:O;if(t){var S=t.prefix,j=t.iconName,D=t.icon;return et(m({type:"icon"},t),function(){return se("beforeDOMElementCreation",{iconDefinition:t,params:n}),v.autoA11y&&(d?b["aria-labelledby"]="".concat(v.replacementClass,"-title-").concat(h||Oe()):(b["aria-hidden"]="true",b.focusable="false")),Lt({icons:{main:gt(D),mask:l?gt(l.icon):{found:!1,width:null,height:null,icon:{}}},prefix:S,iconName:j,transform:m(m({},U),r),symbol:o,title:d,maskId:c,titleId:h,extra:{attributes:b,styles:k,classes:w}})})}},Ei={mixout:function(){return{icon:Pi(_i)}},hooks:function(){return{mutationObserverCallbacks:function(n){return n.treeCallback=vn,n.nodeCallback=Ai,n}}},provides:function(t){t.i2svg=function(n){var a=n.node,r=a===void 0?P:a,i=n.callback,o=i===void 0?function(){}:i;return vn(r,o)},t.generateSvgReplacementMutation=function(n,a){var r=a.iconName,i=a.title,o=a.titleId,s=a.prefix,l=a.transform,f=a.symbol,c=a.mask,u=a.maskId,d=a.extra;return new Promise(function(p,h){Promise.all([yt(r,s),c.iconName?yt(c.iconName,c.prefix):Promise.resolve({found:!1,width:512,height:512,icon:{}})]).then(function(y){var w=St(y,2),x=w[0],b=w[1];p([n,Lt({icons:{main:x,mask:b},prefix:s,iconName:r,transform:l,symbol:f,maskId:u,title:i,titleId:o,extra:d,watchable:!0})])}).catch(h)})},t.generateAbstractIcon=function(n){var a=n.children,r=n.attributes,i=n.main,o=n.transform,s=n.styles,l=Qe(s);l.length>0&&(r.style=l);var f;return Nt(o)&&(f=q("generateAbstractTransformGrouping",{main:i,transform:o,containerWidth:i.width,iconWidth:i.width})),a.push(f||i.icon),{children:a,attributes:r}}}},Ci={mixout:function(){return{layer:function(n){var a=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=a.classes,i=r===void 0?[]:r;return et({type:"layer"},function(){se("beforeDOMElementCreation",{assembler:n,params:a});var o=[];return n(function(s){Array.isArray(s)?s.map(function(l){o=o.concat(l.abstract)}):o=o.concat(s.abstract)}),[{tag:"span",attributes:{class:["".concat(v.cssPrefix,"-layers")].concat(Se(i)).join(" ")},children:o}]})}}}},Ni={mixout:function(){return{counter:function(n){var a=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=a.title,i=r===void 0?null:r,o=a.classes,s=o===void 0?[]:o,l=a.attributes,f=l===void 0?{}:l,c=a.styles,u=c===void 0?{}:c;return et({type:"counter",content:n},function(){return se("beforeDOMElementCreation",{content:n,params:a}),fi({content:n.toString(),title:i,extra:{attributes:f,styles:u,classes:["".concat(v.cssPrefix,"-layers-counter")].concat(Se(s))}})})}}}},Ii={mixout:function(){return{text:function(n){var a=arguments.length>1&&arguments[1]!==void 0?arguments[1]:{},r=a.transform,i=r===void 0?U:r,o=a.title,s=o===void 0?null:o,l=a.classes,f=l===void 0?[]:l,c=a.attributes,u=c===void 0?{}:c,d=a.styles,p=d===void 0?{}:d;return et({type:"text",content:n},function(){return se("beforeDOMElementCreation",{content:n,params:a}),ln({content:n,transform:m(m({},U),i),title:s,extra:{attributes:u,styles:p,classes:["".concat(v.cssPrefix,"-layers-text")].concat(Se(f))}})})}}},provides:function(t){t.generateLayersText=function(n,a){var r=a.title,i=a.transform,o=a.extra,s=null,l=null;if(jn){var f=parseInt(getComputedStyle(n).fontSize,10),c=n.getBoundingClientRect();s=c.width/f,l=c.height/f}return v.autoA11y&&!r&&(o.attributes["aria-hidden"]="true"),Promise.resolve([n,ln({content:n.innerHTML,width:s,height:l,transform:i,title:r,extra:o,watchable:!0})])}}},Ti=new RegExp('"',"ug"),pn=[1105920,1112319];function Mi(e){var t=e.replace(Ti,""),n=Xr(t,0),a=n>=pn[0]&&n<=pn[1],r=t.length===2?t[0]===t[1]:!1;return{value:dt(r?t[0]:t),isSecondary:a||r}}function bn(e,t){var n="".concat(kr).concat(t.replace(":","-"));return new Promise(function(a,r){if(e.getAttribute(n)!==null)return a();var i=ve(e.children),o=i.filter(function(D){return D.getAttribute(mt)===t})[0],s=Z.getComputedStyle(e,t),l=s.getPropertyValue("font-family").match(Pr),f=s.getPropertyValue("font-weight"),c=s.getPropertyValue("content");if(o&&!l)return e.removeChild(o),a();if(l&&c!=="none"&&c!==""){var u=s.getPropertyValue("content"),d=~["Sharp"].indexOf(l[2])?_:A,p=~["Solid","Regular","Light","Thin","Duotone","Brands","Kit"].indexOf(l[2])?we[d][l[2].toLowerCase()]:_r[d][f],h=Mi(u),y=h.value,w=h.isSecondary,x=l[0].startsWith("FontAwesome"),b=Tt(p,y),O=b;if(x){var k=Zr(y);k.iconName&&k.prefix&&(b=k.iconName,p=k.prefix)}if(b&&!w&&(!o||o.getAttribute(Pt)!==p||o.getAttribute(_t)!==O)){e.setAttribute(n,O),o&&e.removeChild(o);var S=Oi(),j=S.extra;j.attributes[mt]=t,yt(b,p).then(function(D){var H=Lt(m(m({},S),{},{icons:{main:D,mask:Mt()},prefix:p,iconName:O,extra:j,watchable:!0})),R=P.createElement("svg");t==="::before"?e.insertBefore(R,e.firstChild):e.appendChild(R),R.outerHTML=H.map(function(Y){return Pe(Y)}).join(`
`),e.removeAttribute(n),a()}).catch(r)}else a()}else a()})}function Li(e){return Promise.all([bn(e,"::before"),bn(e,"::after")])}function $i(e){return e.parentNode!==document.head&&!~Or.indexOf(e.tagName.toUpperCase())&&!e.getAttribute(mt)&&(!e.parentNode||e.parentNode.tagName!=="svg")}function gn(e){if(K)return new Promise(function(t,n){var a=ve(e.querySelectorAll("*")).filter($i).map(Li),r=$t.begin("searchPseudoElements");ia(),Promise.all(a).then(function(){r(),wt(),t()}).catch(function(){r(),wt(),n()})})}var Ri={hooks:function(){return{mutationObserverCallbacks:function(n){return n.pseudoElementsCallback=gn,n}}},provides:function(t){t.pseudoElements2svg=function(n){var a=n.node,r=a===void 0?P:a;v.searchPseudoElements&&gn(r)}}},yn=!1,Fi={mixout:function(){return{dom:{unwatch:function(){ia(),yn=!0}}}},hooks:function(){return{bootstrap:function(){mn(pt("mutationObserverCallbacks",{}))},noAuto:function(){hi()},watch:function(n){var a=n.observeMutationsRoot;yn?wt():mn(pt("mutationObserverCallbacks",{observeMutationsRoot:a}))}}}},hn=function(t){var n={size:16,x:0,y:0,flipX:!1,flipY:!1,rotate:0};return t.toLowerCase().split(" ").reduce(function(a,r){var i=r.toLowerCase().split("-"),o=i[0],s=i.slice(1).join("-");if(o&&s==="h")return a.flipX=!0,a;if(o&&s==="v")return a.flipY=!0,a;if(s=parseFloat(s),isNaN(s))return a;switch(o){case"grow":a.size=a.size+s;break;case"shrink":a.size=a.size-s;break;case"left":a.x=a.x-s;break;case"right":a.x=a.x+s;break;case"up":a.y=a.y-s;break;case"down":a.y=a.y+s;break;case"rotate":a.rotate=a.rotate+s;break}return a},n)},ji={mixout:function(){return{parse:{transform:function(n){return hn(n)}}}},hooks:function(){return{parseNodeAttributes:function(n,a){var r=a.getAttribute("data-fa-transform");return r&&(n.transform=hn(r)),n}}},provides:function(t){t.generateAbstractTransformGrouping=function(n){var a=n.main,r=n.transform,i=n.containerWidth,o=n.iconWidth,s={transform:"translate(".concat(i/2," 256)")},l="translate(".concat(r.x*32,", ").concat(r.y*32,") "),f="scale(".concat(r.size/16*(r.flipX?-1:1),", ").concat(r.size/16*(r.flipY?-1:1),") "),c="rotate(".concat(r.rotate," 0 0)"),u={transform:"".concat(l," ").concat(f," ").concat(c)},d={transform:"translate(".concat(o/2*-1," -256)")},p={outer:s,inner:u,path:d};return{tag:"g",attributes:m({},p.outer),children:[{tag:"g",attributes:m({},p.inner),children:[{tag:a.icon.tag,children:a.icon.children,attributes:m(m({},a.icon.attributes),p.path)}]}]}}}},lt={x:0,y:0,width:"100%",height:"100%"};function wn(e){var t=arguments.length>1&&arguments[1]!==void 0?arguments[1]:!0;return e.attributes&&(e.attributes.fill||t)&&(e.attributes.fill="black"),e}function Di(e){return e.tag==="g"?e.children:[e]}var zi={hooks:function(){return{parseNodeAttributes:function(n,a){var r=a.getAttribute("data-fa-mask"),i=r?Ze(r.split(" ").map(function(o){return o.trim()})):Mt();return i.prefix||(i.prefix=ee()),n.mask=i,n.maskId=a.getAttribute("data-fa-mask-id"),n}}},provides:function(t){t.generateAbstractMask=function(n){var a=n.children,r=n.attributes,i=n.main,o=n.mask,s=n.maskId,l=n.transform,f=i.width,c=i.icon,u=o.width,d=o.icon,p=jr({transform:l,containerWidth:u,iconWidth:f}),h={tag:"rect",attributes:m(m({},lt),{},{fill:"white"})},y=c.children?{children:c.children.map(wn)}:{},w={tag:"g",attributes:m({},p.inner),children:[wn(m({tag:c.tag,attributes:m(m({},c.attributes),p.path)},y))]},x={tag:"g",attributes:m({},p.outer),children:[w]},b="mask-".concat(s||Oe()),O="clip-".concat(s||Oe()),k={tag:"mask",attributes:m(m({},lt),{},{id:b,maskUnits:"userSpaceOnUse",maskContentUnits:"userSpaceOnUse"}),children:[h,x]},S={tag:"defs",children:[{tag:"clipPath",attributes:{id:O},children:Di(d)},k]};return a.push(S,{tag:"rect",attributes:m({fill:"currentColor","clip-path":"url(#".concat(O,")"),mask:"url(#".concat(b,")")},lt)}),{children:a,attributes:r}}}},Yi={provides:function(t){var n=!1;Z.matchMedia&&(n=Z.matchMedia("(prefers-reduced-motion: reduce)").matches),t.missingIconAbstract=function(){var a=[],r={fill:"currentColor"},i={attributeType:"XML",repeatCount:"indefinite",dur:"2s"};a.push({tag:"path",attributes:m(m({},r),{},{d:"M156.5,447.7l-12.6,29.5c-18.7-9.5-35.9-21.2-51.5-34.9l22.7-22.7C127.6,430.5,141.5,440,156.5,447.7z M40.6,272H8.5 c1.4,21.2,5.4,41.7,11.7,61.1L50,321.2C45.1,305.5,41.8,289,40.6,272z M40.6,240c1.4-18.8,5.2-37,11.1-54.1l-29.5-12.6 C14.7,194.3,10,216.7,8.5,240H40.6z M64.3,156.5c7.8-14.9,17.2-28.8,28.1-41.5L69.7,92.3c-13.7,15.6-25.5,32.8-34.9,51.5 L64.3,156.5z M397,419.6c-13.9,12-29.4,22.3-46.1,30.4l11.9,29.8c20.7-9.9,39.8-22.6,56.9-37.6L397,419.6z M115,92.4 c13.9-12,29.4-22.3,46.1-30.4l-11.9-29.8c-20.7,9.9-39.8,22.6-56.8,37.6L115,92.4z M447.7,355.5c-7.8,14.9-17.2,28.8-28.1,41.5 l22.7,22.7c13.7-15.6,25.5-32.9,34.9-51.5L447.7,355.5z M471.4,272c-1.4,18.8-5.2,37-11.1,54.1l29.5,12.6 c7.5-21.1,12.2-43.5,13.6-66.8H471.4z M321.2,462c-15.7,5-32.2,8.2-49.2,9.4v32.1c21.2-1.4,41.7-5.4,61.1-11.7L321.2,462z M240,471.4c-18.8-1.4-37-5.2-54.1-11.1l-12.6,29.5c21.1,7.5,43.5,12.2,66.8,13.6V471.4z M462,190.8c5,15.7,8.2,32.2,9.4,49.2h32.1 c-1.4-21.2-5.4-41.7-11.7-61.1L462,190.8z M92.4,397c-12-13.9-22.3-29.4-30.4-46.1l-29.8,11.9c9.9,20.7,22.6,39.8,37.6,56.9 L92.4,397z M272,40.6c18.8,1.4,36.9,5.2,54.1,11.1l12.6-29.5C317.7,14.7,295.3,10,272,8.5V40.6z M190.8,50 c15.7-5,32.2-8.2,49.2-9.4V8.5c-21.2,1.4-41.7,5.4-61.1,11.7L190.8,50z M442.3,92.3L419.6,115c12,13.9,22.3,29.4,30.5,46.1 l29.8-11.9C470,128.5,457.3,109.4,442.3,92.3z M397,92.4l22.7-22.7c-15.6-13.7-32.8-25.5-51.5-34.9l-12.6,29.5 C370.4,72.1,384.4,81.5,397,92.4z"})});var o=m(m({},i),{},{attributeName:"opacity"}),s={tag:"circle",attributes:m(m({},r),{},{cx:"256",cy:"364",r:"28"}),children:[]};return n||s.children.push({tag:"animate",attributes:m(m({},i),{},{attributeName:"r",values:"28;14;28;28;14;28;"})},{tag:"animate",attributes:m(m({},o),{},{values:"1;0;1;1;0;1;"})}),a.push(s),a.push({tag:"path",attributes:m(m({},r),{},{opacity:"1",d:"M263.7,312h-16c-6.6,0-12-5.4-12-12c0-71,77.4-63.9,77.4-107.8c0-20-17.8-40.2-57.4-40.2c-29.1,0-44.3,9.6-59.2,28.7 c-3.9,5-11.1,6-16.2,2.4l-13.1-9.2c-5.6-3.9-6.9-11.8-2.6-17.2c21.2-27.2,46.4-44.7,91.2-44.7c52.3,0,97.4,29.8,97.4,80.2 c0,67.6-77.4,63.5-77.4,107.8C275.7,306.6,270.3,312,263.7,312z"}),children:n?[]:[{tag:"animate",attributes:m(m({},o),{},{values:"1;0;0;0;0;1;"})}]}),n||a.push({tag:"path",attributes:m(m({},r),{},{opacity:"0",d:"M232.5,134.5l7,168c0.3,6.4,5.6,11.5,12,11.5h9c6.4,0,11.7-5.1,12-11.5l7-168c0.3-6.8-5.2-12.5-12-12.5h-23 C237.7,122,232.2,127.7,232.5,134.5z"}),children:[{tag:"animate",attributes:m(m({},o),{},{values:"0;0;1;1;0;0;"})}]}),{tag:"g",attributes:{class:"missing"},children:a}}}},Vi={hooks:function(){return{parseNodeAttributes:function(n,a){var r=a.getAttribute("data-fa-symbol"),i=r===null?!1:r===""?!0:r;return n.symbol=i,n}}}},Ui=[Yr,Ei,Ci,Ni,Ii,Ri,Fi,ji,zi,Yi,Vi];ni(Ui,{mixoutsTo:$});$.noAuto;$.config;$.library;$.dom;var kt=$.parse;$.findIconDefinition;$.toHtml;var Hi=$.icon;$.layer;$.text;$.counter;function kn(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter(function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable})),n.push.apply(n,a)}return n}function J(e){for(var t=1;t<arguments.length;t++){var n=arguments[t]!=null?arguments[t]:{};t%2?kn(Object(n),!0).forEach(function(a){ue(e,a,n[a])}):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):kn(Object(n)).forEach(function(a){Object.defineProperty(e,a,Object.getOwnPropertyDescriptor(n,a))})}return e}function Be(e){"@babel/helpers - typeof";return Be=typeof Symbol=="function"&&typeof Symbol.iterator=="symbol"?function(t){return typeof t}:function(t){return t&&typeof Symbol=="function"&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t},Be(e)}function ue(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function Wi(e,t){if(e==null)return{};var n={},a=Object.keys(e),r,i;for(i=0;i<a.length;i++)r=a[i],!(t.indexOf(r)>=0)&&(n[r]=e[r]);return n}function Xi(e,t){if(e==null)return{};var n=Wi(e,t),a,r;if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(r=0;r<i.length;r++)a=i[r],!(t.indexOf(a)>=0)&&Object.prototype.propertyIsEnumerable.call(e,a)&&(n[a]=e[a])}return n}function xt(e){return Gi(e)||Bi(e)||qi(e)||Ki()}function Gi(e){if(Array.isArray(e))return Ot(e)}function Bi(e){if(typeof Symbol<"u"&&e[Symbol.iterator]!=null||e["@@iterator"]!=null)return Array.from(e)}function qi(e,t){if(e){if(typeof e=="string")return Ot(e,t);var n=Object.prototype.toString.call(e).slice(8,-1);if(n==="Object"&&e.constructor&&(n=e.constructor.name),n==="Map"||n==="Set")return Array.from(e);if(n==="Arguments"||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return Ot(e,t)}}function Ot(e,t){(t==null||t>e.length)&&(t=e.length);for(var n=0,a=new Array(t);n<t;n++)a[n]=e[n];return a}function Ki(){throw new TypeError(`Invalid attempt to spread non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}function Qi(e){var t,n=e.beat,a=e.fade,r=e.beatFade,i=e.bounce,o=e.shake,s=e.flash,l=e.spin,f=e.spinPulse,c=e.spinReverse,u=e.pulse,d=e.fixedWidth,p=e.inverse,h=e.border,y=e.listItem,w=e.flip,x=e.size,b=e.rotation,O=e.pull,k=(t={"fa-beat":n,"fa-fade":a,"fa-beat-fade":r,"fa-bounce":i,"fa-shake":o,"fa-flash":s,"fa-spin":l,"fa-spin-reverse":c,"fa-spin-pulse":f,"fa-pulse":u,"fa-fw":d,"fa-inverse":p,"fa-border":h,"fa-li":y,"fa-flip":w===!0,"fa-flip-horizontal":w==="horizontal"||w==="both","fa-flip-vertical":w==="vertical"||w==="both"},ue(t,"fa-".concat(x),typeof x<"u"&&x!==null),ue(t,"fa-rotate-".concat(b),typeof b<"u"&&b!==null&&b!==0),ue(t,"fa-pull-".concat(O),typeof O<"u"&&O!==null),ue(t,"fa-swap-opacity",e.swapOpacity),t);return Object.keys(k).map(function(S){return k[S]?S:null}).filter(function(S){return S})}function Ji(e){return e=e-0,e===e}function sa(e){return Ji(e)?e:(e=e.replace(/[\-_\s]+(.)?/g,function(t,n){return n?n.toUpperCase():""}),e.substr(0,1).toLowerCase()+e.substr(1))}var Zi=["style"];function eo(e){return e.charAt(0).toUpperCase()+e.slice(1)}function to(e){return e.split(";").map(function(t){return t.trim()}).filter(function(t){return t}).reduce(function(t,n){var a=n.indexOf(":"),r=sa(n.slice(0,a)),i=n.slice(a+1).trim();return r.startsWith("webkit")?t[eo(r)]=i:t[r]=i,t},{})}function la(e,t){var n=arguments.length>2&&arguments[2]!==void 0?arguments[2]:{};if(typeof t=="string")return t;var a=(t.children||[]).map(function(l){return la(e,l)}),r=Object.keys(t.attributes||{}).reduce(function(l,f){var c=t.attributes[f];switch(f){case"class":l.attrs.className=c,delete t.attributes.class;break;case"style":l.attrs.style=to(c);break;default:f.indexOf("aria-")===0||f.indexOf("data-")===0?l.attrs[f.toLowerCase()]=c:l.attrs[sa(f)]=c}return l},{attrs:{}}),i=n.style,o=i===void 0?{}:i,s=Xi(n,Zi);return r.attrs.style=J(J({},r.attrs.style),o),e.apply(void 0,[t.tag,J(J({},r.attrs),s)].concat(xt(a)))}var fa=!1;try{fa=!0}catch{}function no(){if(!fa&&console&&typeof console.error=="function"){var e;(e=console).error.apply(e,arguments)}}function xn(e){if(e&&Be(e)==="object"&&e.prefix&&e.iconName&&e.icon)return e;if(kt.icon)return kt.icon(e);if(e===null)return null;if(e&&Be(e)==="object"&&e.prefix&&e.iconName)return e;if(Array.isArray(e)&&e.length===2)return{prefix:e[0],iconName:e[1]};if(typeof e=="string")return{prefix:"fas",iconName:e}}function ft(e,t){return Array.isArray(t)&&t.length>0||!Array.isArray(t)&&t?ue({},e,t):{}}var tt=E.forwardRef(function(e,t){var n=e.icon,a=e.mask,r=e.symbol,i=e.className,o=e.title,s=e.titleId,l=e.maskId,f=xn(n),c=ft("classes",[].concat(xt(Qi(e)),xt(i.split(" ")))),u=ft("transform",typeof e.transform=="string"?kt.transform(e.transform):e.transform),d=ft("mask",xn(a)),p=Hi(f,J(J(J(J({},c),u),d),{},{symbol:r,title:o,titleId:s,maskId:l}));if(!p)return no("Could not find icon",f),null;var h=p.abstract,y={ref:t};return Object.keys(e).forEach(function(w){tt.defaultProps.hasOwnProperty(w)||(y[w]=e[w])}),ao(h[0],y)});tt.displayName="FontAwesomeIcon";tt.propTypes={beat:g.bool,border:g.bool,beatFade:g.bool,bounce:g.bool,className:g.string,fade:g.bool,flash:g.bool,mask:g.oneOfType([g.object,g.array,g.string]),maskId:g.string,fixedWidth:g.bool,inverse:g.bool,flip:g.oneOf([!0,!1,"horizontal","vertical","both"]),icon:g.oneOfType([g.object,g.array,g.string]),listItem:g.bool,pull:g.oneOf(["right","left"]),pulse:g.bool,rotation:g.oneOf([0,90,180,270]),shake:g.bool,size:g.oneOf(["2xs","xs","sm","lg","xl","2xl","1x","2x","3x","4x","5x","6x","7x","8x","9x","10x"]),spin:g.bool,spinPulse:g.bool,spinReverse:g.bool,symbol:g.oneOfType([g.bool,g.string]),title:g.string,titleId:g.string,transform:g.oneOfType([g.string,g.object]),swapOpacity:g.bool};tt.defaultProps={border:!1,className:"",mask:null,maskId:null,fixedWidth:!1,inverse:!1,flip:!1,icon:null,listItem:!1,pull:null,pulse:!1,rotation:null,size:null,spin:!1,spinPulse:!1,spinReverse:!1,beat:!1,fade:!1,beatFade:!1,bounce:!1,shake:!1,symbol:!1,title:"",titleId:null,transform:null,swapOpacity:!1};var ao=la.bind(null,E.createElement),oo={prefix:"fas",iconName:"forward-step",icon:[320,512,["step-forward"],"f051","M52.5 440.6c-9.5 7.9-22.8 9.7-34.1 4.4S0 428.4 0 416V96C0 83.6 7.2 72.3 18.4 67s24.5-3.6 34.1 4.4l192 160L256 241V96c0-17.7 14.3-32 32-32s32 14.3 32 32V416c0 17.7-14.3 32-32 32s-32-14.3-32-32V271l-11.5 9.6-192 160z"]},so={prefix:"fas",iconName:"volume-low",icon:[448,512,[128264,"volume-down"],"f027","M301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3zM412.6 181.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5z"]},lo={prefix:"fas",iconName:"circle-play",icon:[512,512,[61469,"play-circle"],"f144","M0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zM188.3 147.1c-7.6 4.2-12.3 12.3-12.3 20.9V344c0 8.7 4.7 16.7 12.3 20.9s16.8 4.1 24.3-.5l144-88c7.1-4.4 11.5-12.1 11.5-20.5s-4.4-16.1-11.5-20.5l-144-88c-7.4-4.5-16.7-4.7-24.3-.5z"]},fo={prefix:"fas",iconName:"circle-stop",icon:[512,512,[62094,"stop-circle"],"f28d","M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM192 160H320c17.7 0 32 14.3 32 32V320c0 17.7-14.3 32-32 32H192c-17.7 0-32-14.3-32-32V192c0-17.7 14.3-32 32-32z"]},co={prefix:"fas",iconName:"volume-high",icon:[640,512,[128266,"volume-up"],"f028","M533.6 32.5C598.5 85.3 640 165.8 640 256s-41.5 170.8-106.4 223.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C557.5 398.2 592 331.2 592 256s-34.5-142.2-88.7-186.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM473.1 107c43.2 35.2 70.9 88.9 70.9 149s-27.7 113.8-70.9 149c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C475.3 341.3 496 301.1 496 256s-20.7-85.3-53.2-111.8c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zm-60.5 74.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3z"]},uo={prefix:"fas",iconName:"backward-step",icon:[320,512,["step-backward"],"f048","M267.5 440.6c9.5 7.9 22.8 9.7 34.1 4.4s18.4-16.6 18.4-29V96c0-12.4-7.2-23.7-18.4-29s-24.5-3.6-34.1 4.4l-192 160L64 241V96c0-17.7-14.3-32-32-32S0 78.3 0 96V416c0 17.7 14.3 32 32 32s32-14.3 32-32V271l11.5 9.6 192 160z"]};export{tt as F,ur as S,lo as a,so as b,co as c,uo as d,oo as e,fo as f};
