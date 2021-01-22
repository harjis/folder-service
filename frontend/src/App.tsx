import React from "react";

import Folders from "./components/Folders";

function App() {
  return (
    <div>
      <Folders accessToken="set me" logout={() => Promise.resolve()} />
    </div>
  );
}

export default App;
