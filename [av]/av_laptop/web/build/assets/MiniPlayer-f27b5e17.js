import{u as R,s as z,r as t,j as e,T as C,B as p,L as I,f as x}from"./index-30f42a89.js";import{R as L}from"./youtube-fd5ba98c.js";import{F as n,f as P,a as b,b as k,S as N,c as _}from"./index-0984e310.js";const E=async a=>{const i=a.match(/([a-z0-9_-]{11})/gim)[0],s=await(await fetch(`https://www.youtube.com/watch?v=${i}`)).text();return JSON.parse(s.split("ytInitialPlayerResponse = ")[1].split(";var meta = document.createElement('meta')")[0]).videoDetails.title};const F=({song:a})=>{const{lang:i}=R(z),[o,s]=t.useState(!0),[l,d]=t.useState(!1),[c,y]=t.useState(85),[h,u]=t.useState(""),[m,f]=t.useState(!1),g=async r=>{const S=await E(r);u(S),s(!0),f(!0)},j=r=>{y(r)},v=()=>{d(!l),x("av_laptop","miniplayer",l)},w=()=>{x("av_laptop","closeMiniPlayer")};return e.jsxs("div",{className:"miniplayer-container",children:[m?e.jsxs(e.Fragment,{children:[e.jsx(C,{order:6,style:{marginLeft:"15px",marginTop:"5px",maxWidth:"400px",maxHeight:"20px",overflow:"hidden",whiteSpace:"nowrap",textOverflow:"ellipsis"},children:h}),e.jsxs("div",{style:{marginTop:"5px"},children:[o?e.jsx(n,{icon:P,onClick:()=>{s(!1)},fontSize:30,style:{marginLeft:"15px",marginRight:"10px"}}):e.jsx(n,{icon:b,onClick:()=>{s(!0)},fontSize:30,style:{marginLeft:"15px",marginRight:"10px"}}),e.jsxs("span",{className:"miniplayer-slider",children:[e.jsx(n,{icon:k}),e.jsx(N,{value:c,onChange:j,size:"sm",style:{width:"100%",marginLeft:"5px",marginRight:"5px"},color:"dark.2"}),e.jsx(n,{icon:_})]}),e.jsxs("span",{className:"miniplayer-buttons",children:[e.jsx(p,{size:"xs",color:"teal.9",onClick:v,children:i.mini_player.minimize}),e.jsx(p,{size:"xs",color:"red.9",style:{marginLeft:"10px"},onClick:w,children:i.mini_player.close})]})]})]}):e.jsx(I,{visible:!m,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"}),e.jsx(L,{url:a,playing:o,height:0,controls:!0,width:0,volume:c/100,onReady:()=>{g(a)},onEnded:()=>{s(!1)},playsinline:!0})]})};export{F as default};