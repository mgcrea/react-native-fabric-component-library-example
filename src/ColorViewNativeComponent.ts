import type { HostComponent, ViewProps } from "react-native";
import type { DirectEventHandler } from "react-native/Libraries/Types/CodegenTypes";
import codegenNativeComponent from "react-native/Libraries/Utilities/codegenNativeComponent";

export type NativeOnTapEvent = {};

export interface NativeColorViewProps extends ViewProps {
  color?: string;
  onTap?: DirectEventHandler<Readonly<NativeOnTapEvent>>;
}

export default codegenNativeComponent<NativeColorViewProps>("NativeColorView", {
  excludedPlatforms: ["android"],
}) as HostComponent<NativeColorViewProps>;
