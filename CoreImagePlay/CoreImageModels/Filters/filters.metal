//
//  LookupFilter.metal
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/17/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" {
    namespace coreimage {
        /// Metal shader language function to be used in a `CIKernel`.
        float4 lookup_filter(sampler src, sampler lookup) {
            float4 textureColor = src.sample(src.coord());

            float blueColor = textureColor.b * 63.0;

            float quad1y = floor(floor(blueColor) / 8.0);
            float quad1x = floor(blueColor) - (quad1y * 8.0);

            float quad2y = floor(ceil(blueColor) / 8.0);
            float quad2x = ceil(blueColor) - (quad2y * 8.0);

            float texPos1x = (quad1x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
            float texPos1y = (quad1y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
            float2 texPos1(texPos1x, texPos1y);

            float texPos2x = (quad2x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
            float texPos2y = (quad2y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
            float2 texPos2(texPos2x, texPos2y);

            float4 newColor1 = lookup.sample(texPos1);
            float4 newColor2 = lookup.sample(texPos2);

            float4 newColor = mix(newColor1, newColor2, fract(blueColor));
            return mix(textureColor, float4(newColor.rgb, textureColor.w), 1);
        }

        /// Helper function that gets the coordinate to sample from.
        float2 get_coord(float midX, sampler src, destination dest) {
            float distFromMidX = dest.coord().x - midX;
            float2 sampleCoord = src.transform(dest.coord() - float2(2 * distFromMidX, 0));
            return sampleCoord;
        }

        /// Metal shader language function to be used in a `CIKernel`.
        float4 horizontal_mirror_transform(sampler src, float lToR, destination dest) {

            float midX = src.extent().z / 2;

            if ((lToR == 1 && dest.coord().x > midX) || (lToR == -1 && dest.coord().x < midX)) {
                return src.sample(get_coord(midX, src, dest));
            } else {
                return src.sample(src.coord());
            }
        }
    }
}
