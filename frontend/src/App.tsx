import React from "react";

import Folders from "./components/Folders";

const foldersChildrenByFolderId = {
  1: [<div>Folder 1 child 1</div>, <div>Folder 1 child 2</div>],
  2: [<div>Folder 2 child 1</div>],
};
function App() {
  return (
    <div>
      <Folders foldersChildrenByFolderId={foldersChildrenByFolderId} />
    </div>
  );
}

export default App;
