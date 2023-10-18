import{j as e,T as f,u as p,s as A,y as I,r,m as b,B as G,z as P,F as j,f as m,_,L as v,b as R,x as F,G as T}from"./index-28ac6c93.js";import{M as $}from"./ModalMenu-a55b458a.js";import{G as w}from"./Grid-d6e08076.js";import{M as V}from"./Menu-6531da33.js";import{C as y}from"./Card-3dfeee0b.js";import{G as S}from"./Group-9c8fb92d.js";import{B as C}from"./Badge-2d8cfea3.js";import{T as N}from"./Tooltip-125658a2.js";import{S as q}from"./Select-ec223a6d.js";import{A as H}from"./AppShell-ca867994.js";import{N as W}from"./Navbar-3d1ae847.js";const J=({currentTab:l,setCurrentTab:s,permissions:i})=>e.jsxs("div",{className:"re-navbar",children:[e.jsx("span",{className:"re-navOption",style:{borderStyle:l=="home"?"none none none solid":"none",borderColor:l=="home"?"#339AF0":"none"},onClick:()=>{s("home")},children:e.jsxs("span",{className:"navOption-content",children:[e.jsx("i",{className:"fa-solid fa-house",style:{fontSize:"16px"}}),e.jsx(f,{order:6,children:"Home"})]})}),i.motelsTab&&e.jsx("span",{className:"re-navOption",style:{borderStyle:l=="motels"?"none none none solid":"none",borderColor:l=="motels"?"#339AF0":"none"},onClick:()=>{s("motels")},children:e.jsxs("span",{className:"navOption-content",children:[e.jsx("i",{className:"fa-solid fa-bed",style:{fontSize:"16px"}}),e.jsx(f,{order:6,children:"Motels"})]})}),i.storageTab&&e.jsx("span",{className:"re-navOption",style:{borderStyle:l=="storages"?"none none none solid":"none",borderColor:l=="storages"?"#339AF0":"none"},onClick:()=>{s("storages")},children:e.jsxs("span",{className:"navOption-content",children:[e.jsx("i",{className:"fa-solid fa-warehouse",style:{fontSize:"16px"}}),e.jsx(f,{order:6,children:"Storages"})]})})]}),K=({currentTab:l})=>{const{lang:s}=p(A),i={home:s.realestate.available_properties,motels:s.realestate.motels_tab,storages:s.realestate.storages_tab};return e.jsx(f,{order:3,style:{marginLeft:"5px",padding:"5px",fontStyle:"italic"},children:i[l]})};const Q=({currentAds:l,permissions:s,categories:i})=>{const{lang:o}=p(A),{serial:h}=p(I),[c,d]=r.useState(!1),[n,a]=r.useState({}),[g,x]=r.useState(9999),k=t=>{if(g===t){x(9999);return}x(t)},z=t=>{a({title:t.title,options:[{height:200,title:o.realestate.image,type:"image",image:t.img,style:{marginTop:"10px",borderRadius:"4px"}},{type:"textarea",label:o.realestate.description,description:t.description,style:{marginTop:"10px"}}],extraData:{event:"no"}}),d(!0)},O=()=>{a({title:o.realestate.ad_title,button:o.realestate.confirm_button,options:[{name:"title",type:"text",title:o.realestate.title,icon:"fa-solid fa-pen-to-square",asterisk:!0},{name:"image",type:"text",title:o.realestate.photo,icon:"fa-solid fa-image",style:{marginTop:"5px"},asterisk:!0},{name:"price",type:"number",title:o.realestate.price,icon:"fa-solid fa-hand-holding-dollar",style:{marginTop:"5px"}},{name:"type",type:"select",title:o.realestate.type,default:"house",options:i,style:{marginTop:"5px"}},{name:"description",type:"textarea",label:o.realestate.description,style:{marginTop:"10px"},asterisk:!0}],extraData:{event:"newPost"}}),d(!0)},L=t=>{var u;d(!1),t!=null&&t.extraData&&m("av_realestate",(u=t==null?void 0:t.extraData)==null?void 0:u.event,t)},M=t=>{m("av_realestate","gps",t)},E=t=>{m("av_realestate","copy",t)},B=t=>{m("av_realestate","deleteAd",t)};return e.jsxs("div",{className:"ads-container",children:[c&&e.jsx($,{callback:L,data:n}),(s==null?void 0:s.createAds)&&e.jsx("div",{style:{position:"absolute",zIndex:"200",bottom:b(45),right:b(20)},children:e.jsx(G,{leftIcon:e.jsx("i",{className:"fa-regular fa-square-plus"}),onClick:O,children:"New Ad"})}),e.jsx(w,{columns:2,children:l.map((t,u)=>e.jsx(V,{shadow:"md",width:120,position:"bottom-end",onClose:()=>{k(999)},children:e.jsx(w.Col,{className:"ads-card",children:e.jsxs(y,{shadow:"sm",padding:"xs",radius:"md",withBorder:!0,children:[e.jsx(y.Section,{children:e.jsx(P,{src:t.img,height:160,alt:t.identifier})}),e.jsxs(y.Section,{style:{padding:"10px"},children:[e.jsx(j,{weight:500,style:{maxWidth:"100%",overflow:"hidden",whiteSpace:"nowrap",textOverflow:"ellipsis"},color:"gray.3",children:t.title}),e.jsxs(S,{position:"left",mt:"1px",mb:"0",spacing:"10px",children:[e.jsxs("span",{style:{display:"inline-flex",width:"50%",alignItems:"center"},children:[e.jsx("i",{className:"fa-solid fa-location-dot",style:{fontSize:"10px",color:"white"}}),e.jsx(j,{id:"ad-text",weight:500,size:11,color:"gray.5",style:{marginLeft:"4px"},truncate:!0,onClick:()=>{M(t.coords)},children:t.location})]}),e.jsx("span",{style:{width:"44%"},children:e.jsxs(j,{weight:500,size:11,color:"gray.5",truncate:!0,id:"ad-text",onClick:()=>{E(t.phone)},children:[e.jsx("a",{style:{fontWeight:"700",width:"10px"},children:o.realestate.phone}),` ${t.phone}`]})})]}),e.jsxs(S,{position:"left",mt:"10px",mb:"0",spacing:"3px",children:[e.jsx(C,{color:"grape.1",defaultChecked:!0,size:"sm",children:t.type}),t.price&&e.jsx(C,{color:"teal.1",defaultChecked:!0,size:"sm",children:`$${t.price}`}),e.jsxs("span",{style:{display:"inline-flex",marginLeft:"auto"},children:[e.jsx(N,{label:o.realestate.more_info,color:"dark.7",withArrow:!0,children:e.jsx("i",{id:"ad-button",className:"fa-solid fa-circle-info",style:{fontSize:"14px",opacity:"0.85"},onClick:()=>{z(t)}})}),h==t.author||s.deleteAds?e.jsx(N,{label:o.realestate.delete,color:"dark.7",withArrow:!0,children:e.jsx("i",{id:"ad-button",className:"fa-solid fa-circle-xmark",style:{fontSize:"14px",opacity:"0.85",marginLeft:"8px"},onClick:()=>{B(t)}})}):null]})]})]})]})})},u))})]})},U=r.lazy(()=>_(()=>import("./Storages-518bf2b9.js"),["./Storages-518bf2b9.js","./index-28ac6c93.js","./index-ec2a5f13.css","./AccordionComponent-a03f44f2.js","./ModalMenu-a55b458a.js","./Modal-0d2caa8f.js","./Paper-6c49ea1c.js","./use-window-event-a1a40cb7.js","./NumberInput-8b8c01a0.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js","./clamp-23377890.js","./Select-ec223a6d.js","./ScrollArea-ac70a87a.js","./Tooltip-125658a2.js","./Table-fd6dc87d.js","./Indicator-7ce1218e.js","./Badge-2d8cfea3.js","./Accordion-64c792ed.js","./get-safe-id-7e16e55a.js","./create-scoped-keydown-handler-f8889cf4.js","./Menu-6531da33.js","./IconTrash-10d30b72.js","./Storages-3cedd98e.css"],import.meta.url)),X=r.lazy(()=>_(()=>import("./Motels-87ed89fc.js"),["./Motels-87ed89fc.js","./index-28ac6c93.js","./index-ec2a5f13.css","./AccordionComponent-a03f44f2.js","./ModalMenu-a55b458a.js","./Modal-0d2caa8f.js","./Paper-6c49ea1c.js","./use-window-event-a1a40cb7.js","./NumberInput-8b8c01a0.js","./TextInput-10182490.js","./use-input-props-89bc61eb.js","./clamp-23377890.js","./Select-ec223a6d.js","./ScrollArea-ac70a87a.js","./Tooltip-125658a2.js","./Table-fd6dc87d.js","./Indicator-7ce1218e.js","./Badge-2d8cfea3.js","./Accordion-64c792ed.js","./get-safe-id-7e16e55a.js","./create-scoped-keydown-handler-f8889cf4.js","./Menu-6531da33.js","./IconTrash-10d30b72.js"],import.meta.url)),Y=({currentTab:l,appData:s})=>{const[i,o]=r.useState(s==null?void 0:s.categories),[h,c]=r.useState(s==null?void 0:s.ads),d=n=>{const a=n.toLowerCase(),g=s==null?void 0:s.ads.filter(x=>a=="all"?s==null?void 0:s.ads:x.type.toLowerCase().includes(a));c(g)};return r.useEffect(()=>{const n=[...s==null?void 0:s.categories,{value:"all",label:"All"}];o(n),c(s==null?void 0:s.ads)},[s]),e.jsxs("div",{className:"re-main-container",children:[e.jsxs("div",{className:"re-header",children:[e.jsx(K,{currentTab:l}),l==="home"&&e.jsx(q,{defaultValue:"all",placeholder:"All",data:i,onChange:d,style:{marginRight:"5px"}})]}),e.jsxs("div",{className:"re-body",children:[l=="home"&&e.jsx(Q,{currentAds:h,permissions:s==null?void 0:s.permissions,categories:s==null?void 0:s.categories}),l=="storages"&&e.jsx(e.Fragment,{children:e.jsx(r.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"},children:e.jsx(v,{visible:!0,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"})}),children:e.jsx(U,{})})}),l=="motels"&&e.jsx(e.Fragment,{children:e.jsx(r.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"},children:e.jsx(v,{visible:!0,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"})}),children:e.jsx(X,{})})})]})]})};const ce=()=>{const l=R(),[s,i]=r.useState("home"),[o,h]=r.useState({ads:[],categories:[],permissions:[]}),[c,d]=r.useState(!0);return F("updateAds",n=>{const a={...o,ads:n};h(a)}),r.useEffect(()=>{(async()=>{const a=await m("av_realestate","getData");h(a),l(T(a.permissions)),d(!0)})()},[]),e.jsx("div",{children:c?e.jsx(H,{padding:"0px",navbar:e.jsx(W,{width:{base:100},height:"100%",p:"0",sx:{overflow:"auto"},children:e.jsx(J,{currentTab:s,setCurrentTab:i,permissions:o==null?void 0:o.permissions})}),styles:n=>({main:{backgroundColor:n.colorScheme==="dark"?n.colors.dark[8]:n.colors.gray[0],borderStyle:"none none none none"}}),children:e.jsx(Y,{currentTab:s,appData:o})}):e.jsx(v,{visible:!c,overlayBlur:2})})};export{ce as default};