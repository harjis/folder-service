import React, { Suspense } from "react";
import { useRecoilValue } from "recoil";

import { rootsAtom } from "../../atoms/folders";
import { Loading } from "../Loading/Loading";
import { Folder } from "./Folder";

const Folders: React.FC = () => {
  const roots = useRecoilValue(rootsAtom);

  return (
    <ul>
      {roots.map((root) => (
        <Folder key={root.id} folder={root} />
      ))}
    </ul>
  );
};

const FoldersContainer: React.FC = () => {
  return (
    <Suspense fallback={<Loading message="root folders" />}>
      <Folders />
    </Suspense>
  );
};

export default FoldersContainer;
