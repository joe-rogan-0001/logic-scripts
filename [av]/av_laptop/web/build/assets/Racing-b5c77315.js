import{u as n,s as h,aa as c,j as e,r as s,_ as l,L as u}from"./index-30f42a89.js";import{T as i}from"./Tabs-ee4e508f.js";const x=({currentTab:t,setCurrentTab:r})=>{const{lang:a}=n(h),{crew:o,isCop:d}=n(c);return e.jsx(i,{defaultValue:t,color:"cyan.4",onTabChange:r,bg:"#25262B",children:e.jsxs(i.List,{children:[e.jsx(i.Tab,{value:"home",children:a.racing.home_tab}),e.jsx(i.Tab,{value:"tracks",children:a.racing.tracks_tab}),d?null:e.jsx(i.Tab,{value:"leaderboard",children:a.racing.leaderboard_tab}),o?e.jsx(i.Tab,{value:"crew",children:a.racing.crew_tab}):null,e.jsx(i.Tab,{value:"settings",ml:"auto",children:a.racing.settings_tab})]})})},_=s.lazy(()=>l(()=>import("./Home-ad0374a2.js"),["./Home-ad0374a2.js","./index-30f42a89.js","./index-ec2a5f13.css","./Timer-206be5fc.js","./GetTrackType-d081291d.js","./ModalMenu-4d728021.js","./Modal-e582506a.js","./Paper-2f68e4b7.js","./use-window-event-42fe4f53.js","./NumberInput-37ed4568.js","./TextInput-0d64c543.js","./use-input-props-99b71066.js","./clamp-23377890.js","./Select-811cb72a.js","./ScrollArea-ea370493.js","./Accordion-613cbac9.js","./get-safe-id-7e16e55a.js","./create-scoped-keydown-handler-f8889cf4.js","./Flex-a3f901b7.js","./Badge-5a2eb96f.js","./Tooltip-9bb34c92.js","./IconUserPlus-33f1d021.js","./IconTrash-29367d2b.js","./Table-02c47a96.js","./Group-b310a18c.js","./Group.styles-52bce6e0.js","./Home-d297290b.css"],import.meta.url)),j=s.lazy(()=>l(()=>import("./Profile-893f67c8.js"),["./Profile-893f67c8.js","./index-30f42a89.js","./index-ec2a5f13.css","./TextInput-0d64c543.js","./use-input-props-99b71066.js","./NumberInput-37ed4568.js","./clamp-23377890.js","./Tooltip-9bb34c92.js","./Select-811cb72a.js","./ScrollArea-ea370493.js","./use-window-event-42fe4f53.js","./Group-b310a18c.js","./Group.styles-52bce6e0.js","./CheckboxIcon-c7f36901.js","./Grid-ccdb07e6.js"],import.meta.url)),m=s.lazy(()=>l(()=>import("./Crew-366c04fc.js"),["./Crew-366c04fc.js","./index-30f42a89.js","./index-ec2a5f13.css","./Flex-a3f901b7.js","./TextInput-0d64c543.js","./use-input-props-99b71066.js","./index-572d1837.js","./Group-b310a18c.js","./Group.styles-52bce6e0.js","./CheckboxIcon-c7f36901.js","./use-window-event-42fe4f53.js","./Menu-f2938afd.js","./create-scoped-keydown-handler-f8889cf4.js","./Table-02c47a96.js","./Paper-2f68e4b7.js","./ScrollArea-ea370493.js","./sortBy-e0864bc9.js","./Tooltip-9bb34c92.js","./IconUserPlus-33f1d021.js","./IconTrash-29367d2b.js","./ModalMenu-4d728021.js","./Modal-e582506a.js","./NumberInput-37ed4568.js","./clamp-23377890.js","./Select-811cb72a.js","./Grid-ccdb07e6.js","./Crew-adf34c6c.css"],import.meta.url)),p=s.lazy(()=>l(()=>import("./Leaderboard-69593f83.js"),["./Leaderboard-69593f83.js","./index-30f42a89.js","./index-ec2a5f13.css","./index-572d1837.js","./Group-b310a18c.js","./Group.styles-52bce6e0.js","./CheckboxIcon-c7f36901.js","./use-window-event-42fe4f53.js","./Menu-f2938afd.js","./create-scoped-keydown-handler-f8889cf4.js","./Table-02c47a96.js","./Paper-2f68e4b7.js","./ScrollArea-ea370493.js","./sortBy-e0864bc9.js","./TextInput-0d64c543.js","./use-input-props-99b71066.js","./Leaderboard-a12c0f33.css"],import.meta.url)),b=s.lazy(()=>l(()=>import("./Tracks-7c7834ad.js"),["./Tracks-7c7834ad.js","./index-30f42a89.js","./index-ec2a5f13.css","./Card-73f8d616.js","./Paper-2f68e4b7.js","./Flex-a3f901b7.js","./Badge-5a2eb96f.js","./Tooltip-9bb34c92.js","./IconTrash-29367d2b.js","./GetTrackType-d081291d.js","./IconFlame-4063da0b.js","./Select-811cb72a.js","./ScrollArea-ea370493.js","./use-window-event-42fe4f53.js","./use-input-props-99b71066.js","./TextInput-0d64c543.js","./ModalMenu-4d728021.js","./Modal-e582506a.js","./NumberInput-37ed4568.js","./clamp-23377890.js","./Table-02c47a96.js","./Group-b310a18c.js","./Group.styles-52bce6e0.js","./Tracks-0587c8f8.css"],import.meta.url)),g=({currentTab:t})=>{const{crew:r}=n(c);return e.jsxs("div",{className:"boosting-container",children:[t=="home"&&e.jsx(s.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:e.jsx(_,{})}),t=="tracks"&&e.jsx(s.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:e.jsx(b,{})}),t=="leaderboard"&&e.jsx(s.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:e.jsx(p,{})}),t=="crew"&&e.jsx(s.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:e.jsx(m,{crew:r})}),t=="settings"&&e.jsx(s.Suspense,{fallback:e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"}}),children:e.jsx(j,{})})]})};const f=()=>{const[t,r]=s.useState(!1),[a,o]=s.useState("home");return s.useEffect(()=>{r(!1)},[]),e.jsx("div",{className:"racing-container",children:t?e.jsx("div",{style:{position:"absolute",width:"100%",height:"100%"},children:e.jsx(u,{visible:t,overlayBlur:2,overlayColor:"rgba(20, 21, 23, 1)"})}):e.jsxs(e.Fragment,{children:[e.jsx("div",{className:"racing-header",children:e.jsx(x,{currentTab:a,setCurrentTab:o})}),e.jsx(g,{currentTab:a})]})})};export{f as default};