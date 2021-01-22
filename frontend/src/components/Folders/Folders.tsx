import React, { Suspense } from "react";
import { RecoilRoot, useRecoilValue } from "recoil";

import { rootsAtom } from "../../atoms/folders";
import { Loading } from "../Loading/Loading";
import { Folder } from "./Folder";
import { AuthStore } from "../../stores/AuthStore";

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

type PropsFromAuthenticationService = {
  accessToken: string;
  logout: () => Promise<void>;
};
const FoldersContainer: React.FC<PropsFromAuthenticationService> = (props) => {
  AuthStore.setAccessToken(props.accessToken);
  return (
    <RecoilRoot>
      <Suspense fallback={<Loading message="root folders" />}>
        <Folders />
      </Suspense>
    </RecoilRoot>
  );
};

export default FoldersContainer;
