#define PHYSICAL
	attribute float instanceScale;

	varying float vScale;
	varying vec3 vViewPosition;
	varying vec3 vPosition;
	
	#ifndef FLAT_SHADED
		varying vec3 vNormal;
		#ifdef USE_TANGENT
			varying vec3 vTangent;
			varying vec3 vBitangent;
		#endif
	#endif
	
	#include <common>
	#include <uv_pars_vertex>
	#include <uv2_pars_vertex>
	#include <color_pars_vertex>
	#include <shadowmap_pars_vertex>

	void main() {
		vScale = instanceScale;
	
		#include <uv_vertex>
		#include <uv2_vertex>
		#include <color_vertex>
	
		#include <beginnormal_vertex>
		#include <defaultnormal_vertex>
	
		#ifndef FLAT_SHADED // Normal computed with derivatives when FLAT_SHADED
		
			vNormal = normalize( transformedNormal );
		
			#ifdef USE_TANGENT
		
				vTangent = normalize( transformedTangent );
				vBitangent = normalize( cross( vNormal, vTangent ) * tangent.w );
		
			#endif
		
		#endif
	
		#include <begin_vertex>

		#include <project_vertex>

		vViewPosition = -mvPosition.xyz;
		vPosition = position;

		#include <worldpos_vertex>
		#include <shadowmap_vertex>
	}