import{m as o,S as q,n as G,o as _,r as H,a as J,R as s,e as w,F as O}from"./index-28ac6c93.js";import{T as K}from"./Tooltip-125658a2.js";const k={xs:o(3),sm:o(5),md:o(8),lg:o(12),xl:o(16)},Q=q({from:{backgroundPosition:"0 0"},to:{backgroundPosition:`${o(40)} 0`}});var U=G((a,{color:r,radius:e},{size:t})=>({root:{position:"relative",height:_({size:t,sizes:k}),backgroundColor:a.colorScheme==="dark"?a.colors.dark[4]:a.colors.gray[2],borderRadius:a.fn.radius(e),overflow:"hidden"},bar:{position:"absolute",top:0,bottom:0,left:0,height:"100%",display:"flex",justifyContent:"center",alignItems:"center",backgroundColor:a.fn.variant({variant:"filled",primaryFallback:!1,color:r||a.primaryColor}).background,transition:"width 100ms linear","&[data-animate]":{animation:`${Q} 1000ms linear infinite`},"&[data-striped]":{backgroundSize:`${o(20)} ${o(20)}`,backgroundImage:"linear-gradient(45deg, rgba(255, 255, 255, 0.15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.15) 50%, rgba(255, 255, 255, 0.15) 75%, transparent 75%, transparent)"},"&:last-of-type":{borderTopRightRadius:a.fn.radius(e),borderBottomRightRadius:a.fn.radius(e)},"&:first-of-type":{borderTopLeftRadius:a.fn.radius(e),borderBottomLeftRadius:a.fn.radius(e)},"@media (prefers-reduced-motion)":{transitionDuration:a.respectReducedMotion?"0ms":void 0}},label:{color:a.white,fontSize:`calc(${_({size:t,sizes:k})} * 0.65)`,fontWeight:700,userSelect:"none",overflow:"hidden",whiteSpace:"nowrap"}}));const X=U;var Y=Object.defineProperty,Z=Object.defineProperties,aa=Object.getOwnPropertyDescriptors,n=Object.getOwnPropertySymbols,R=Object.prototype.hasOwnProperty,x=Object.prototype.propertyIsEnumerable,S=(a,r,e)=>r in a?Y(a,r,{enumerable:!0,configurable:!0,writable:!0,value:e}):a[r]=e,c=(a,r)=>{for(var e in r||(r={}))R.call(r,e)&&S(a,e,r[e]);if(n)for(var e of n(r))x.call(r,e)&&S(a,e,r[e]);return a},h=(a,r)=>Z(a,aa(r)),N=(a,r)=>{var e={};for(var t in a)R.call(a,t)&&r.indexOf(t)<0&&(e[t]=a[t]);if(a!=null&&n)for(var t of n(a))r.indexOf(t)<0&&x.call(a,t)&&(e[t]=a[t]);return e};function ea(a){return a.reduce((r,e)=>(r.sections.push(h(c({},e),{accumulated:r.accumulated})),r.accumulated+=e.value,r),{accumulated:0,sections:[]}).sections}const ra={size:"md",radius:"sm",striped:!1,animate:!1,label:""},ta=H.forwardRef((a,r)=>{const e=J("Progress",ra,a),{className:t,value:d,color:C,size:E,radius:$,striped:u,animate:i,label:m,"aria-label":j,classNames:z,styles:T,sections:p,unstyled:D,variant:F}=e,I=N(e,["className","value","color","size","radius","striped","animate","label","aria-label","classNames","styles","sections","unstyled","variant"]),{classes:l,cx:f,theme:b}=X({color:C,radius:$},{name:"Progress",classNames:z,styles:T,unstyled:D,variant:F,size:E}),L=Array.isArray(p)?ea(p).map((A,B)=>{var v=A,{tooltip:g,accumulated:V,value:M,label:y,color:W}=v,P=N(v,["tooltip","accumulated","value","label","color"]);return s.createElement(K.Floating,{label:g,disabled:!g,key:B},s.createElement(w,h(c({},P),{className:f(l.bar,P.className),"data-striped":u||i||void 0,"data-animate":i||void 0,sx:{width:`${M}%`,left:`${V}%`,backgroundColor:b.fn.variant({variant:"filled",primaryFallback:!1,color:W||b.primaryColor}).background}}),y&&s.createElement(O,{className:l.label},y)))}):null;return s.createElement(w,c({className:f(l.root,t),ref:r},I),L||s.createElement("div",{role:"progressbar","aria-valuemax":100,"aria-valuemin":0,"aria-valuenow":d,"aria-label":j,className:l.bar,style:{width:`${d}%`},"data-striped":u||i||void 0,"data-animate":i||void 0},m?s.createElement(O,{className:l.label},m):""))});ta.displayName="@mantine/core/Progress";export{ta as P};