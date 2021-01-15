declare namespace LoadingModuleCssNamespace {
  export interface ILoadingModuleCss {
    container: string;
  }
}

declare const LoadingModuleCssModule: LoadingModuleCssNamespace.ILoadingModuleCss & {
  /** WARNING: Only available when `css-loader` is used without `style-loader` or `mini-css-extract-plugin` */
  locals: LoadingModuleCssNamespace.ILoadingModuleCss;
};

export = LoadingModuleCssModule;
