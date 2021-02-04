import React, { Suspense } from "react";

import Folders from "./components/Folders";
import { RecoilRoot } from "recoil";
import { Loading } from "./components/Loading/Loading";

const itemsByFolderId = {
  1: ["Root Node"],
  2: ["Child 1 File", "Child 2 File"],
};
function App() {
  return (
    <RecoilRoot>
      <Suspense fallback={<Loading message="root folders" />}>
        <Folders
          accessToken="set me"
          logout={() => Promise.resolve()}
          itemsByFolderId={itemsByFolderId}
        />
      </Suspense>
    </RecoilRoot>
  );
}

export default App;
