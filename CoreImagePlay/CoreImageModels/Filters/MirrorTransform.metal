//
//  MirrorTransform.metal
//  CoreImagePlay
//
//  Created by Sharar Arzuk Rahman on 3/15/19.
//  Copyright © 2019 Sharar Arzuk Rahman. All rights reserved.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>

using namespace metal;

extern "C" {
    namespace coreimage {
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
