import{u as h,s as m,j as s,e as p,T as b,E as w,C as d,D as C,f as c,r as u,m as x,B as v}from"./index-30f42a89.js";import{G as f}from"./Grid-ccdb07e6.js";const N=({data:t,handleDelete:i})=>{const{lang:n}=h(m),e=l=>{c("av_laptop","copy",l)};return s.jsxs(f.Col,{className:"application-card",span:3,children:[s.jsxs(p,{style:{display:"flex",width:"95%",justifyContent:"space-between",marginLeft:"auto",marginRight:"auto"},mt:7,children:[s.jsx(b,{order:5,weight:600,ml:5,color:"gray.3",children:t.name}),s.jsx(w,{color:"red.5",variant:"subtle","aria-label":n.business.close_button,onClick:()=>{i(t.identifier)},mr:10})]}),s.jsxs(p,{mt:5,mb:5,style:{width:"90%",marginLeft:"auto",marginRight:"auto"},children:[s.jsx(d,{size:14,ta:"justify",children:t.description}),s.jsx(C,{mt:10}),s.jsxs(p,{style:{display:"flex",marginTop:"10px",justifyContent:"space-between",width:"95%",marginLeft:"auto",marginRight:"auto"},children:[s.jsxs(d,{size:12,weight:500,color:"gray.4",className:"info-text",onClick:()=>{e(t.phone)},children:[s.jsx("i",{className:"fa-solid fa-phone",style:{color:"rgba(255,255,255,0.75)"}})," ",` ${t.phone}`]}),s.jsxs(d,{size:12,weight:500,color:"gray.4",className:"info-text",onClick:()=>{e(t.email)},children:[s.jsx("i",{className:"fa-solid fa-at",style:{color:"rgba(255,255,255,0.75)"}})," ",` ${t.email}`]})]})]})]})};const A=()=>{const{lang:t}=h(m),[i,n]=u.useState([]),[e,l]=u.useState(!0),g=a=>{if(i.find(r=>r.identifier===a)){c("av_restaurants","deleteApplication",a);const r=i.filter(y=>y.identifier!==a);n(r)}},j=()=>{c("av_restaurants","applicationsStatus",{status:!e}),l(!e)};return u.useEffect(()=>{(async()=>{const o=await c("av_restaurants","getApplications");n(o.list),l(o.status)})()},[]),s.jsxs("div",{className:"application-container",children:[s.jsx("div",{style:{position:"absolute",zIndex:"200",bottom:x(45),right:x(20)},children:s.jsx(v,{leftIcon:s.jsx("i",{className:e?"fa-solid fa-lock-open":"fa-solid fa-lock"}),onClick:j,color:e?"teal.8":"red.8",children:e?`${t.business.open}`:`${t.business.closed}`})}),s.jsx("div",{style:{width:"100%"},children:s.jsx(f,{columns:3,grow:!0,gutter:"xs",children:i.map((a,o)=>s.jsx(N,{data:a,handleDelete:g},o))})})]})};export{A as default};