import{u as v,s as z,r as n,x as S,j as e,L as T,J as _,F as o,B as L,f as p}from"./index-28ac6c93.js";import{M as C}from"./ModalMenu-a55b458a.js";import{T as W}from"./Timer-a1d064f3.js";import{G as u}from"./Grid-d6e08076.js";import{F as a}from"./Flex-a153c916.js";const E=()=>{const{lang:t}=v(z),[l,h]=n.useState(!0),[i,g]=n.useState(!1),[f,r]=n.useState(!1),[m,b]=n.useState({}),[d,c]=n.useState([]),j=s=>{b({title:t.boosting.place_bid,options:[{name:"bid",icon:"fa-solid fa-circle-dollar-to-slot",title:t.boosting.bid_amount,type:"number",asterisk:!0}],button:t.boosting.confirm_button,extraData:{event:"placeBid",contract:s}}),r(!0)},w=async s=>{r(!1),s&&p("av_boosting",s.extraData.event,s)};return S("updateAuctions",s=>{c(s)}),n.useEffect(()=>{window.innerWidth<=1300&&g(!0),(async()=>{const y=await p("av_boosting","getAuctions");c(y),setTimeout(()=>{h(!1)},250)})()},[]),e.jsxs(e.Fragment,{children:[f&&e.jsx(C,{callback:w,data:m}),l?e.jsx("div",{style:{position:"relative",width:"100%",height:"100%"},children:e.jsx(T,{visible:l,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"})}):e.jsx(e.Fragment,{children:d[0]?e.jsx(u,{gutter:"sm",style:{marginTop:"5px"},children:d.map((s,x)=>e.jsx(u.Col,{className:"boosting-contract",children:e.jsxs(a,{justify:"center",align:"center",direction:"row",wrap:"nowrap",sx:{justifyContent:"space-between"},children:[e.jsxs("span",{style:{display:"inline-flex"},children:[e.jsx(_,{style:{marginTop:"2px",backgroundColor:"rgba(10,10,10,1)",border:"solid 2px",borderColor:"#7950F2",marginLeft:i?"0px":"5px"},radius:100,size:i?40:45,children:s.class}),e.jsxs(a,{justify:"flex-start",align:"flex-start",direction:"column",wrap:"wrap",style:{marginLeft:"15px"},children:[e.jsxs(o,{weight:500,size:i?14:16,children:["Vehicle: ",e.jsx("a",{style:{fontWeight:"400",textTransform:"capitalize"},children:s.label})]}),e.jsxs(o,{weight:500,size:i?14:16,children:["Owner: ",e.jsx("a",{style:{fontWeight:"400",textTransform:"capitalize"},children:s.owner})]})]})]}),e.jsxs(a,{justify:"flex-start",align:"flex-start",direction:"column",wrap:"wrap",children:[e.jsxs(o,{weight:500,size:i?14:16,style:{display:"inline-flex"},children:["Ends in: ",e.jsx("a",{style:{fontWeight:"400"},children:e.jsx(W,{deadline:s.auctionSeconds,expired:t.boosting.ending})})]}),e.jsxs(o,{weight:500,size:i?14:16,children:[t.boosting.current_bid," ",e.jsx("a",{style:{fontWeight:"400"},children:`${s.bid} ${t.boosting.crypto}`})]})]}),e.jsx("span",{style:{display:"inline-flex",marginRight:"10px"},children:e.jsx(L,{size:"sm",color:"teal.9",onClick:()=>{j(s)},disabled:s.auctionSeconds<=50,children:s.auctionSeconds<=50?`${t.boosting.ending_soon}`:`${t.boosting.place_bid}`})})]})},x))}):e.jsx("div",{className:"profile-container",children:e.jsx(o,{size:16,weight:600,children:t.boosting.no_auctions})})})]})};export{E as default};