import{r as i,a as P,R as w,e as x}from"./index-28ac6c93.js";import{u as G}from"./Group.styles-31d56db6.js";function N(r){return i.Children.toArray(r).filter(Boolean)}var C=Object.defineProperty,n=Object.getOwnPropertySymbols,s=Object.prototype.hasOwnProperty,p=Object.prototype.propertyIsEnumerable,l=(r,a,e)=>a in r?C(r,a,{enumerable:!0,configurable:!0,writable:!0,value:e}):r[a]=e,E=(r,a)=>{for(var e in a||(a={}))s.call(a,e)&&l(r,e,a[e]);if(n)for(var e of n(a))p.call(a,e)&&l(r,e,a[e]);return r},R=(r,a)=>{var e={};for(var t in r)s.call(r,t)&&a.indexOf(t)<0&&(e[t]=r[t]);if(r!=null&&n)for(var t of n(r))a.indexOf(t)<0&&p.call(r,t)&&(e[t]=r[t]);return e};const b={position:"left",spacing:"md"},j=i.forwardRef((r,a)=>{const e=P("Group",b,r),{className:t,position:f,align:c,children:m,noWrap:u,grow:d,spacing:_,unstyled:v,variant:g}=e,y=R(e,["className","position","align","children","noWrap","grow","spacing","unstyled","variant"]),o=N(m),{classes:O,cx:h}=G({align:c,grow:d,noWrap:u,spacing:_,position:f,count:o.length},{unstyled:v,name:"Group",variant:g});return w.createElement(x,E({className:h(O.root,t),ref:a},y),o)});j.displayName="@mantine/core/Group";export{j as G};