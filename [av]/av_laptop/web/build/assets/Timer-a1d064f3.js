import{r as o,j as S}from"./index-28ac6c93.js";const h=({deadline:e,expired:c})=>{const[a,u]=o.useState(""),[m,i]=o.useState(e),$=()=>{e-=1,i(e),u(f(e))},f=t=>{const r=Math.floor(t/3600),s=Math.floor(t%3600/60),n=t%60,l=r<10?`0${r}`:`${r}`,T=s<10?`0${s}`:`${s}`,x=n<10?`0${n}`:`${n}`;return`${l}:${T}:${x}`};return o.useEffect(()=>{const t=setInterval(()=>$(),1e3);return()=>clearInterval(t)},[]),S.jsx("div",{className:"timer",children:m>0?`${a}`:`${c}`})};export{h as T};