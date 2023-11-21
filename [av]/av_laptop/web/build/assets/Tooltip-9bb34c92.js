import{r as p,R as i,aW as Re,n as $e,aX as re,aY as te,aZ as Te,X as ne,a as ae,aE as se,v as le,aT as ie,e as pe,Y as Ce,a_ as Se,a$ as Me,b0 as Ie,b1 as Ne,b2 as Fe,b3 as je,b4 as Ge,b5 as ze,b6 as ke,b7 as Le,b8 as Ae,b9 as Be,aG as He,ba as Ue,p as Ve,bb as Xe}from"./index-30f42a89.js";const ce=p.createContext(!1),Ye=ce.Provider,Ze=()=>p.useContext(ce);function de({children:e,openDelay:o=0,closeDelay:r=0}){return i.createElement(Ye,{value:!0},i.createElement(Re,{delay:{open:o,close:r}},e))}de.displayName="@mantine/core/TooltipGroup";var We=Object.defineProperty,qe=Object.defineProperties,Je=Object.getOwnPropertyDescriptors,J=Object.getOwnPropertySymbols,Ke=Object.prototype.hasOwnProperty,Qe=Object.prototype.propertyIsEnumerable,K=(e,o,r)=>o in e?We(e,o,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[o]=r,Q=(e,o)=>{for(var r in o||(o={}))Ke.call(o,r)&&K(e,r,o[r]);if(J)for(var r of J(o))Qe.call(o,r)&&K(e,r,o[r]);return e},eo=(e,o)=>qe(e,Je(o));function oo(e,o){if(!o)return{backgroundColor:e.colorScheme==="dark"?e.colors.gray[2]:e.colors.gray[9],color:e.colorScheme==="dark"?e.black:e.white};const r=e.fn.variant({variant:"filled",color:o,primaryFallback:!1});return{backgroundColor:r.background,color:r.color}}var ro=$e((e,{color:o,radius:r,width:t,multiline:a})=>({tooltip:eo(Q(Q({},e.fn.fontStyles()),oo(e,o)),{lineHeight:e.lineHeight,fontSize:e.fontSizes.sm,borderRadius:e.fn.radius(r),padding:`calc(${e.spacing.xs} / 2) ${e.spacing.xs}`,position:"absolute",whiteSpace:a?"unset":"nowrap",pointerEvents:"none",width:t}),arrow:{backgroundColor:"inherit",border:0,zIndex:1}}));const ue=ro,fe={children:"Tooltip component children should be an element or a component that accepts ref, fragments, strings, numbers and other primitive values are not supported"};function to({offset:e,position:o}){const[r,t]=p.useState(!1),a=p.useRef(),{x:s,y:d,reference:m,floating:y,refs:u,update:P,placement:_}=re({placement:o,middleware:[te({crossAxis:!0,padding:5,rootBoundary:"document"})]}),b=_.includes("right")?e:o.includes("left")?e*-1:0,g=_.includes("bottom")?e:o.includes("top")?e*-1:0,f=p.useCallback(({clientX:n,clientY:l})=>{m({getBoundingClientRect(){return{width:0,height:0,x:n,y:l,left:n+b,top:l+g,right:n,bottom:l}}})},[m]);return p.useEffect(()=>{if(u.floating.current){const n=a.current;n.addEventListener("mousemove",f);const l=Te(u.floating.current);return l.forEach(w=>{w.addEventListener("scroll",P)}),()=>{n.removeEventListener("mousemove",f),l.forEach(w=>{w.removeEventListener("scroll",P)})}}},[m,u.floating.current,P,f,r]),{handleMouseMove:f,x:s,y:d,opened:r,setOpened:t,boundaryRef:a,floating:y}}var no=Object.defineProperty,ao=Object.defineProperties,so=Object.getOwnPropertyDescriptors,G=Object.getOwnPropertySymbols,ve=Object.prototype.hasOwnProperty,me=Object.prototype.propertyIsEnumerable,ee=(e,o,r)=>o in e?no(e,o,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[o]=r,F=(e,o)=>{for(var r in o||(o={}))ve.call(o,r)&&ee(e,r,o[r]);if(G)for(var r of G(o))me.call(o,r)&&ee(e,r,o[r]);return e},j=(e,o)=>ao(e,so(o)),lo=(e,o)=>{var r={};for(var t in e)ve.call(e,t)&&o.indexOf(t)<0&&(r[t]=e[t]);if(e!=null&&G)for(var t of G(e))o.indexOf(t)<0&&me.call(e,t)&&(r[t]=e[t]);return r};const io={refProp:"ref",withinPortal:!0,offset:10,position:"right",zIndex:ne("popover")};function Pe(e){var o;const r=ae("TooltipFloating",io,e),{children:t,refProp:a,withinPortal:s,portalProps:d,style:m,className:y,classNames:u,styles:P,unstyled:_,radius:b,color:g,label:f,offset:n,position:l,multiline:w,width:O,zIndex:$,disabled:T,variant:C}=r,x=lo(r,["children","refProp","withinPortal","portalProps","style","className","classNames","styles","unstyled","radius","color","label","offset","position","multiline","width","zIndex","disabled","variant"]),{handleMouseMove:S,x:v,y:I,opened:L,boundaryRef:A,floating:M,setOpened:N}=to({offset:n,position:l}),{classes:B,cx:H}=ue({radius:b,color:g,multiline:w,width:O},{name:"TooltipFloating",classNames:u,styles:P,unstyled:_,variant:C});if(!se(t))throw new Error(fe.children);const U=le(A,t.ref),V=R=>{var h,E;(E=(h=t.props).onMouseEnter)==null||E.call(h,R),S(R),N(!0)},X=R=>{var h,E;(E=(h=t.props).onMouseLeave)==null||E.call(h,R),N(!1)};return i.createElement(i.Fragment,null,i.createElement(ie,j(F({},d),{withinPortal:s}),i.createElement(pe,j(F({},x),{ref:M,className:H(B.tooltip,y),style:j(F({},m),{zIndex:$,display:!T&&L?"block":"none",top:I??"",left:(o=Math.round(v))!=null?o:""})}),f)),p.cloneElement(t,j(F({},t.props),{[a]:U,onMouseEnter:V,onMouseLeave:X})))}Pe.displayName="@mantine/core/TooltipFloating";function po(e){const[o,r]=p.useState(!1),a=typeof e.opened=="boolean"?e.opened:o,s=Ze(),d=Ce(),{delay:m,currentId:y,setCurrentId:u}=Se(),P=p.useCallback(v=>{r(v),v&&u(d)},[u,d]),{x:_,y:b,reference:g,floating:f,context:n,refs:l,update:w,placement:O,middlewareData:{arrow:{x:$,y:T}={}}}=re({placement:e.position,open:a,onOpenChange:P,middleware:[Me(e.offset),te({padding:8}),Ie(),Ne({element:e.arrowRef,padding:e.arrowOffset}),...e.inline?[Fe()]:[]]}),{getReferenceProps:C,getFloatingProps:x}=je([Ge(n,{enabled:e.events.hover,delay:s?m:{open:e.openDelay,close:e.closeDelay},mouseOnly:!e.events.touch}),ze(n,{enabled:e.events.focus,keyboardOnly:!0}),ke(n,{role:"tooltip"}),Le(n,{enabled:typeof e.opened===void 0}),Ae(n,{id:d})]);return Be({opened:a,position:e.position,positionDependencies:e.positionDependencies,floating:{refs:l,update:w}}),He(()=>{var v;(v=e.onPositionChange)==null||v.call(e,O)},[O]),{x:_,y:b,arrowX:$,arrowY:T,reference:g,floating:f,getFloatingProps:x,getReferenceProps:C,isGroupPhase:a&&y&&y!==d,opened:a,placement:O}}var co=Object.defineProperty,uo=Object.defineProperties,fo=Object.getOwnPropertyDescriptors,z=Object.getOwnPropertySymbols,we=Object.prototype.hasOwnProperty,ye=Object.prototype.propertyIsEnumerable,oe=(e,o,r)=>o in e?co(e,o,{enumerable:!0,configurable:!0,writable:!0,value:r}):e[o]=r,D=(e,o)=>{for(var r in o||(o={}))we.call(o,r)&&oe(e,r,o[r]);if(z)for(var r of z(o))ye.call(o,r)&&oe(e,r,o[r]);return e},Y=(e,o)=>uo(e,fo(o)),vo=(e,o)=>{var r={};for(var t in e)we.call(e,t)&&o.indexOf(t)<0&&(r[t]=e[t]);if(e!=null&&z)for(var t of z(e))o.indexOf(t)<0&&ye.call(e,t)&&(r[t]=e[t]);return r};const mo={position:"top",refProp:"ref",withinPortal:!1,inline:!1,arrowSize:4,arrowOffset:5,arrowRadius:0,arrowPosition:"side",offset:5,transitionProps:{duration:100,transition:"fade"},width:"auto",events:{hover:!0,focus:!1,touch:!1},zIndex:ne("popover"),positionDependencies:[]},k=p.forwardRef((e,o)=>{var r;const t=p.useRef(null),a=ae("Tooltip",mo,e),{children:s,position:d,refProp:m,label:y,openDelay:u,closeDelay:P,onPositionChange:_,opened:b,withinPortal:g,portalProps:f,radius:n,color:l,classNames:w,styles:O,unstyled:$,style:T,className:C,withArrow:x,arrowSize:S,arrowOffset:v,arrowRadius:I,arrowPosition:L,offset:A,transitionProps:M,multiline:N,width:B,events:H,zIndex:U,disabled:V,positionDependencies:X,onClick:R,onMouseEnter:h,onMouseLeave:E,inline:_e,variant:be,keepMounted:ge}=a,Oe=vo(a,["children","position","refProp","label","openDelay","closeDelay","onPositionChange","opened","withinPortal","portalProps","radius","color","classNames","styles","unstyled","style","className","withArrow","arrowSize","arrowOffset","arrowRadius","arrowPosition","offset","transitionProps","multiline","width","events","zIndex","disabled","positionDependencies","onClick","onMouseEnter","onMouseLeave","inline","variant","keepMounted"]),{classes:Z,cx:he,theme:Ee}=ue({radius:n,color:l,width:B,multiline:N},{name:"Tooltip",classNames:w,styles:O,unstyled:$,variant:be}),c=po({position:Ue(Ee.dir,d),closeDelay:P,openDelay:u,onPositionChange:_,opened:b,events:H,arrowRef:t,arrowOffset:v,offset:A+(x?S/2:0),positionDependencies:[...X,s],inline:_e});if(!se(s))throw new Error(fe.children);const De=le(c.reference,s.ref,o);return i.createElement(i.Fragment,null,i.createElement(ie,Y(D({},f),{withinPortal:g}),i.createElement(Ve,Y(D({keepMounted:ge,mounted:!V&&c.opened},M),{transition:M.transition||"fade",duration:c.isGroupPhase?10:(r=M.duration)!=null?r:100}),xe=>{var W,q;return i.createElement(pe,D(D({},Oe),c.getFloatingProps({ref:c.floating,className:Z.tooltip,style:Y(D(D({},T),xe),{zIndex:U,top:(W=c.y)!=null?W:0,left:(q=c.x)!=null?q:0})})),y,i.createElement(Xe,{ref:t,arrowX:c.arrowX,arrowY:c.arrowY,visible:x,position:c.placement,arrowSize:S,arrowOffset:v,arrowRadius:I,arrowPosition:L,className:Z.arrow}))})),p.cloneElement(s,c.getReferenceProps(D({onClick:R,onMouseEnter:h,onMouseLeave:E,onMouseMove:e.onMouseMove,onPointerDown:e.onPointerDown,onPointerEnter:e.onPointerEnter,[m]:De,className:he(C,s.props.className)},s.props))))});k.Group=de;k.Floating=Pe;k.displayName="@mantine/core/Tooltip";const wo=k;export{wo as T};