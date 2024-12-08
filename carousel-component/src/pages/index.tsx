import { CustomCaruselShadcn } from "@/components/CustomCaruselShadcn";


export default function Home() {
  return (
    <div>
      <CustomCaruselShadcn layout="desktop" amountOfSlides={5} />
      <CustomCaruselShadcn layout="desktop" amountOfSlides={1} />
      <CustomCaruselShadcn layout="mobile" amountOfSlides={5} />
      <CustomCaruselShadcn layout="mobile" amountOfSlides={1} />
      </div>
  );
}
