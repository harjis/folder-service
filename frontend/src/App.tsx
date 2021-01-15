import React from "react";

import Folders from "./components/Folders";
import { RecoilRoot } from "recoil";

function App() {
  return (
    <RecoilRoot>
      <div>
        <Folders />
      </div>
    </RecoilRoot>
  );
}

export default App;
