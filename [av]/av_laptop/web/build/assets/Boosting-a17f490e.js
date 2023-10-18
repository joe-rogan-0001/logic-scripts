import{c as u,b as j,q as C,u as p,s as b,M as v,j as o,e as x,m as g,U as y,J as w,F as d,O as M,f,r as n,_ as h,L as z,Q as S}from"./index-28ac6c93.js";import{M as c}from"./Menu-6531da33.js";import{G as _}from"./Group-9c8fb92d.js";import{I as L}from"./Indicator-7ce1218e.js";import{I as T}from"./IconSettings-6d76ad50.js";import{I as A,T as E}from"./IconClipboardList-b86e31d5.js";import{P}from"./Progress-1af144a2.js";import{A as R}from"./AppShell-ca867994.js";import{N as m}from"./Navbar-3d1ae847.js";import{H as D}from"./Header-5608f27c.js";var O=u("gavel","IconGavel",[["path",{d:"M13 10l7.383 7.418c.823 .82 .823 2.148 0 2.967a2.11 2.11 0 0 1 -2.976 0l-7.407 -7.385",key:"svg-0"}],["path",{d:"M6 9l4 4",key:"svg-1"}],["path",{d:"M13 10l-4 -4",key:"svg-2"}],["path",{d:"M3 21h7",key:"svg-3"}],["path",{d:"M6.793 15.793l-3.586 -3.586a1 1 0 0 1 0 -1.414l2.293 -2.293l.5 .5l3 -3l-.5 -.5l2.293 -2.293a1 1 0 0 1 1.414 0l3.586 3.586a1 1 0 0 1 0 1.414l-2.293 2.293l-.5 -.5l-3 3l.5 .5l-2.293 2.293a1 1 0 0 1 -1.414 0z",key:"svg-4"}]]),q=u("login","IconLogin",[["path",{d:"M14 8v-2a2 2 0 0 0 -2 -2h-7a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7a2 2 0 0 0 2 -2v-2",key:"svg-0"}],["path",{d:"M20 12h-13l3 -3m0 6l-3 -3",key:"svg-1"}]]),B=u("trophy","IconTrophy",[["path",{d:"M8 21l8 0",key:"svg-0"}],["path",{d:"M12 17l0 4",key:"svg-1"}],["path",{d:"M7 4l10 0",key:"svg-2"}],["path",{d:"M17 4v8a5 5 0 0 1 -10 0v-8",key:"svg-3"}],["path",{d:"M5 9m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0",key:"svg-4"}],["path",{d:"M19 9m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0",key:"svg-5"}]]);function $({setCurrentTab:t}){const l=j(),s=C(),{lang:r}=p(b),{queue:a,name:e,photo:i,crypto:k}=p(v),I=()=>{l(M(!a)),f("av_boosting","queue",{queue:!a})};return o.jsx(x,{sx:{paddingTop:s.spacing.sm,borderTop:`${g(1)} solid ${s.colorScheme==="dark"?s.colors.dark[4]:s.colors.gray[2]}`},children:o.jsxs(c,{shadow:"md",width:200,position:"top-start",withArrow:!0,children:[o.jsx(c.Target,{children:o.jsx(y,{sx:{display:"block",width:"100%",padding:s.spacing.xs,borderRadius:s.radius.sm,color:s.colorScheme==="dark"?s.colors.dark[0]:s.black,"&:hover":{backgroundColor:s.colorScheme==="dark"?s.colors.dark[6]:s.colors.gray[0]}},children:o.jsxs(_,{children:[o.jsx(L,{color:a?"green":"red",processing:!!a,children:o.jsx(w,{src:i,radius:"md",placeholder:e})}),o.jsxs(x,{sx:{flex:1,width:"110px"},children:[o.jsx(d,{size:"sm",weight:500,truncate:"end",children:e}),o.jsx(d,{color:"dimmed",size:"xs",truncate:"end",children:`${r.boosting.crypto}: ${k}`})]})]})})}),o.jsxs(c.Dropdown,{children:[o.jsx(c.Label,{children:r.boosting.boosting_options}),o.jsx(c.Item,{icon:o.jsx(T,{size:14}),onClick:()=>{t("profile")},children:r.boosting.my_profile}),o.jsx(c.Item,{icon:o.jsx(q,{size:14}),onClick:I,children:a?`${r.boosting.leave_queue}`:`${r.boosting.join_queue}`})]})]})})}function N({icon:t,color:l,label:s,option:r,index:a}){return o.jsx(y,{sx:e=>({display:"block",width:"100%",padding:e.spacing.sm,borderRadius:e.radius.sm,color:e.colorScheme==="dark"?e.colors.dark[0]:e.black,backgroundColor:r==a?e.colors.dark[6]:"","&:hover":{color:"rgba(230,230,230,1)"}}),children:o.jsxs(_,{children:[o.jsx(E,{color:l,variant:"light",children:t}),o.jsx(d,{size:"sm",children:s})]})})}function G({currentTab:t,setCurrentTab:l}){const{lang:s}=p(b),a=[{icon:o.jsx(A,{size:"1rem"}),color:"blue.1",label:s.boosting.contracts_tab,option:"contracts"},{icon:o.jsx(O,{size:"1rem"}),color:"teal.1",label:s.boosting.auction_tab,option:"auction"},{icon:o.jsx(B,{size:"1rem"}),color:"violet.1",label:s.boosting.leaderboard_tab,option:"leaderboard"}].map(e=>o.jsx("span",{onClick:()=>{l(e.option)},children:o.jsx(N,{icon:e.icon,color:e.color,label:e.label,option:e.option,index:t})},e.label));return o.jsx("div",{style:{padding:"10px"},children:a})}const V=()=>{const{currentClass:t,nextClass:l,level:s}=p(v);return o.jsx("div",{style:{marginTop:"31px"},children:o.jsxs("span",{style:{display:"inline-flex",width:"100%",alignContent:"center",justifyContent:"center",alignItems:"center",marginLeft:"auto",marginRight:"auto",textAlign:"center"},children:[o.jsx(d,{weight:500,size:14,children:t}),o.jsx(P,{value:s,size:"sm",color:"teal.5",style:{width:"100%",marginLeft:"5px",marginRight:"5px"}}),o.jsx(d,{weight:500,size:14,children:l})]})})},F=n.lazy(()=>h(()=>import("./ContractMain-0152cb02.js"),["./ContractMain-0152cb02.js","./index-28ac6c93.js","./index-ec2a5f13.css","./Timer-a1d064f3.js","./ModalMenu-a55b458a.js","./Modal-0d2caa8f.js","./Paper-6c49ea1c.js","./use-window-event-a1a40cb7.js","./NumberInput-8b8c01a0.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js","./clamp-23377890.js","./Select-ec223a6d.js","./ScrollArea-ac70a87a.js","./Grid-d6e08076.js","./Flex-a153c916.js","./Tooltip-125658a2.js","./IconFlame-d0c90505.js","./IconTrash-10d30b72.js"],import.meta.url)),Q=n.lazy(()=>h(()=>import("./Auctions-edbc776d.js"),["./Auctions-edbc776d.js","./index-28ac6c93.js","./index-ec2a5f13.css","./ModalMenu-a55b458a.js","./Modal-0d2caa8f.js","./Paper-6c49ea1c.js","./use-window-event-a1a40cb7.js","./NumberInput-8b8c01a0.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js","./clamp-23377890.js","./Select-ec223a6d.js","./ScrollArea-ac70a87a.js","./Timer-a1d064f3.js","./Grid-d6e08076.js","./Flex-a153c916.js"],import.meta.url)),U=n.lazy(()=>h(()=>import("./Leaderboard-280b63cd.js"),["./Leaderboard-280b63cd.js","./index-28ac6c93.js","./index-ec2a5f13.css","./index-a6223248.js","./Group-9c8fb92d.js","./Group.styles-31d56db6.js","./CheckboxIcon-9366b07d.js","./use-window-event-a1a40cb7.js","./Menu-6531da33.js","./create-scoped-keydown-handler-f8889cf4.js","./Table-fd6dc87d.js","./Paper-6c49ea1c.js","./ScrollArea-ac70a87a.js","./sortBy-5f1ec268.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js"],import.meta.url)),H=n.lazy(()=>h(()=>import("./Profile-ac9bdd4c.js"),["./Profile-ac9bdd4c.js","./index-28ac6c93.js","./index-ec2a5f13.css","./imageExists-ca14fa46.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js"],import.meta.url)),J=({currentTab:t})=>o.jsxs("div",{className:"boosting-container",children:[t=="contracts"&&o.jsx(n.Suspense,{fallback:o.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:o.jsx(F,{})}),t=="auction"&&o.jsx(n.Suspense,{fallback:o.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:o.jsx(Q,{})}),t=="leaderboard"&&o.jsx(n.Suspense,{fallback:o.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:o.jsx(U,{})}),t=="profile"&&o.jsx(n.Suspense,{fallback:o.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:o.jsx(H,{})})]});const K=()=>{const t=j(),[l,s]=n.useState(!1),[r,a]=n.useState("contracts");return n.useEffect(()=>{(async()=>{const i=await f("av_boosting","getData");t(S({name:i.name,photo:i.photo,level:parseInt(i.level),contracts:i.contracts,crypto:i.crypto,inContract:i.inContract,queue:i.queue,currentClass:i.currentClass,nextClass:i.nextClass})),setTimeout(()=>{s(!1)},300)})()},[]),o.jsx(o.Fragment,{children:l?o.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"},children:o.jsx(z,{visible:l,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"})}):o.jsx(R,{padding:"0px",navbar:o.jsx(m,{height:"100%",width:{base:200},children:o.jsx(m.Section,{grow:!0,children:o.jsxs(o.Fragment,{children:[o.jsx(G,{currentTab:r,setCurrentTab:a}),o.jsx("span",{style:{position:"absolute",zIndex:"200",bottom:g(85),right:g(10)},children:o.jsx($,{setCurrentTab:a})})]})})}),header:o.jsx(D,{height:75,p:"xs",children:o.jsx(V,{})}),styles:e=>({main:{backgroundColor:e.colorScheme==="dark"?e.colors.dark[8]:e.colors.gray[0],marginTop:"-31px"}}),children:o.jsx(J,{currentTab:r})})})},io=Object.freeze(Object.defineProperty({__proto__:null,default:K},Symbol.toStringTag,{value:"Module"}));export{io as B,O as I};