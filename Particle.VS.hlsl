#include "Particle.hlsli"

struct TransformationMatrix {
	float4x4 wvp;
	float4x4 World;
};

StructuredBuffer<TransformationMatrix> gTransformationMatrices : register(t0);

struct VertexShaderInput {
	float4 position : POSITION0;
	float2 texcoord : TEXCOORD0;
	float3 normal : NORMAL0;
};

VertexShaderOutput main(VertexShaderInput input,int instanceId : SV_InstanceID) {
	VertexShaderOutput output;
	output.position = mul(input.position, gTransformationMatrices[instanceId].wvp);
	output.texcoord = input.texcoord;
	output.normal = normalize(mul(input.normal, (float3x3)gTransformationMatrices[instanceId].World));
	return output;
}
