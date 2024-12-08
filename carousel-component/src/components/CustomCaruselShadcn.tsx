import * as React from "react";
import { Card, CardContent } from "@/components/ui/card";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
  type CarouselApi,
} from "@/components/ui/carousel";

interface CarouselProps {
  layout: "mobile" | "desktop";
  amountOfSlides: number;
}

export function CustomCaruselShadcn({ layout = "mobile", amountOfSlides = 5 }: CarouselProps) {
  const [api, setApi] = React.useState<CarouselApi>();
  const [current, setCurrent] = React.useState(0);

  const carouselContainerRef = React.useRef<HTMLDivElement>(null);

  React.useEffect(() => {
    if (!api) return;

    setCurrent(api.selectedScrollSnap());

    api.on("select", () => {
      setCurrent(api.selectedScrollSnap());
    });
  }, [api]);

  const isMobile = layout === "mobile";
  const slides = Array.from({ length: amountOfSlides });

  return (
    <div
      className={`relative mx-auto w-full ${isMobile ? "max-w-[30%]" : "max-w-[70%]"}`}
      ref={carouselContainerRef}
    >
      <div className="h-80 flex items-center justify-center">
        <Carousel
          setApi={setApi}
          opts={{
            align: "center",
            containScroll: false,
          }}
          className="w-full -mb-4"
        >
          <CarouselContent className={`flex items-center ${isMobile ? "gap-0" : "gap-4"}`}>
            {slides.map((_, index) => (
              <CarouselItem
                key={index}
                className={`transition-opacity transition-transform duration-150 ease-in-out ${isMobile
                    ? amountOfSlides === 1
                      ? "basis-[75%] mx-auto"
                      : "basis-[75%]"
                    : amountOfSlides === 1
                      ? "basis-[70%] mx-auto"
                      : amountOfSlides > 1
                        ? index === current
                          ? "basis-2/3 transform scale-100 z-10"
                          : index === current - 1 || index === current + 1
                            ? "basis-1/4 transform scale-95"
                            : "basis-1/6"
                        : "basis-[70%]"
                  }`}
              >
                <Card className="h-full border-none">
                  <CardContent
                    className={`flex items-center justify-center h-40 bg-slide rounded-lg ${isMobile && amountOfSlides > 1
                        ? index === current
                          ? "opacity-100 bg-gray-200"
                          : index === current + 1
                            ? "opacity-75 bg-gradient-to-l from-90% from-white to-gray-300"
                            : index === current - 1
                              ? "opacity-75 bg-gradient-to-r from-90% from-white to-gray-300"
                              : "opacity-30 bg-white"
                        : index === current
                          ? "bg-gray-200"
                          : index === current - 1
                            ? "opacity-75 bg-gradient-to-r from-60% from-white to-gray-300"
                            : index === current + 1
                              ? "opacity-75 bg-gradient-to-l from-60% from-white to-gray-300"
                              : "bg-white opacity-50"
                      }`}
                  >
                    <img
                      src={index === current ? "/slide.png" : "/clear.png"}
                      height="150px"
                      width="150px"
                      className="mt-5"
                    />
                  </CardContent>
                </Card>
              </CarouselItem>
            ))}
          </CarouselContent>

          {!isMobile && amountOfSlides > 1 && (
            <>
              <CarouselPrevious
                className="absolute left-0 top-1/2 -translate-y-1/2 p-2 bg-white text-gray-800 rounded-full z-10"
                onClick={() => api?.scrollPrev()}
              >
                &#8249;
              </CarouselPrevious>
              <CarouselNext
                className="absolute right-0 top-1/2 -translate-y-1/2 p-2 bg-white text-gray-800 rounded-full z-10"
                onClick={() => api?.scrollNext()}
              >
                &#8250;
              </CarouselNext>
            </>
          )}
        </Carousel>
      </div>
      <div
        className="mx-auto -mt-16 h-[1px] bg-gray-200"
        style={{
          width: carouselContainerRef.current?.offsetWidth || "100%",
        }}
      ></div>
    </div>
  );
}
